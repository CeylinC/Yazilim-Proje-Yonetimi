import 'package:flutter/material.dart';
import 'package:sound/widget/Button.dart';
import 'package:sound/widget/Image.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<String?> uploadFile() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://127.0.0.1:8000/uploadfile/'));
  request.files
      .add(await http.MultipartFile.fromPath('file', 'output_audio.wav'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    return null;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sound Guessing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _uploadResult;

  void _handleFileUpload() async {
    String? result = await uploadFile();
    setState(() {
      _uploadResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Histogram(
                  imagePath: 'lib/assets/histogram.jpg',
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Sound Owner",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "FM Score",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ACC Score",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Text",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_uploadResult?.substring(15, _uploadResult!.length - 8) ?? "None"),
                          const Text("10"),
                          const Text("30"),
                          Container(
                            width: screenWidth * 2 / 3,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 500),
                            child: const Text(
                              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                              softWrap: true,
                              maxLines: 30,
                            ),
                          )
                        ],
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Button(uploadFile: _handleFileUpload),
                )
              ],
            ),
          ),
        ));
  }
}

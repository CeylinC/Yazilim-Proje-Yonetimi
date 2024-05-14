import 'package:flutter/material.dart';
import 'package:sound/widget/Button.dart';
import 'package:sound/widget/Image.dart';

void main() {
  runApp(const MyApp());
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
                          const Text("Ramazan Yıldırım"),
                          const Text("10"),
                          const Text("30"),
                          Container(
                            width: screenWidth * 2 / 3,
                            constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
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
                  child: Button(),
                )
              ],
            ),
          ),
        ));
  }
}

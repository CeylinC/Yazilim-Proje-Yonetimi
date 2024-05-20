import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop_audio_recorder/flutter_desktop_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class Button extends StatefulWidget {
  @override
  _Button createState() => _Button();
}

class _Button extends State<Button> {
  bool _hasMicPermission = false;
  FlutterDesktopAudioRecorder recorder = FlutterDesktopAudioRecorder();
  String _fileName = "output_audio";
  String buttonText = "Start";
  int _counter = 5;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    recorder.permissionGrantedListener = () {
      if (!mounted) return;
      setState(() {
        _hasMicPermission = true;
      });
    };
  }

  Future<void> initPlatformState() async {
    _hasMicPermission = await recorder.hasMicPermission();
    if (!mounted) return;
    setState(() {});
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (_counter >= 0) {
          _counter--;
        }
      });
      if (_counter == -1) {
        buttonText = "Again";
        _counter = 5;
        stopRecording();
        return;
      }
      startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: recorder.isRecording(),
        builder: (context, snapshot) {
          bool? isRecording = snapshot.data;
          return Center(
              child: Column(
            children: [
              startRecordingButton(snapshot, isRecording),
            ],
          ));
        });
  }

  ElevatedButton startRecordingButton(
      AsyncSnapshot<bool> snapshot, bool? isRecording) {
    return ElevatedButton(
        onPressed: () async {
          if (snapshot.data != null) {
            if (snapshot.data!) {
              stopRecording().then((value) {
                setState(() {});
              });
              setState(() {});
            } else {
              startRecording().then((value) {
                recorder.isRecording().then((value) {
                  startCountdown();
                });
                setState(() {});
              });
              setState(() {});
            }
          }
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), padding: const EdgeInsets.all(36)),
        child: Text(isRecording == null
            ? "Initializing"
            : !_hasMicPermission
                ? "Request Mic Permission"
                : isRecording
                    ? '$_counter'
                    : buttonText));
  }

  Future stopRecording() async {
    return recorder.stop();
  }

  Future startRecording() async {
    _fileName = "output_audio";
    String path = await Utilities.getVoiceFilePath();
    try {
      return await recorder.start(path: path, fileName: _fileName);
    } on PlatformException catch (e) {
      switch (e.code) {
        case "permissionError":
          recorder.requestMicPermission();
          break;
        default:
      }
      log(e.message ?? "Unhandled error");
    }
  }
}

class Utilities {
  static Future<String> getVoiceFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = appDocumentsPath;
    return filePath;
  }
}

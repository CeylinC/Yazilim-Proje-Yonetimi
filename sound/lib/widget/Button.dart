import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  @override
  _Button createState() => _Button();
}

class _Button extends State<Button> {
  String buttonText = "Start";
  int _countdown = 6;

  @override
  void initState() {
    super.initState();
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (_countdown > 0) {
          buttonText = (--_countdown).toString();
        }
      });
      if (_countdown == 0) {
        buttonText = "Again";
        _countdown = 6;
        return;
      }
      startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (ElevatedButton(
        onPressed: () => {startCountdown()},
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), padding: const EdgeInsets.all(36)),
        child: Text(buttonText)));
  }
}

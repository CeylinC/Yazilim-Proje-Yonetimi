import 'package:flutter/material.dart';

class Histogram extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const Histogram({
    required this.imagePath,
    this.width = 1000.0,
    this.height = 300.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: const Alignment(0.0, -0.72),
            image: AssetImage(imagePath),
          ),
        ),
        child: const Text("Histogram: ", style: TextStyle(fontWeight: FontWeight.bold,)));
  }
}

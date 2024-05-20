import 'package:flutter/material.dart';

class Histogram extends StatefulWidget{
  const Histogram({super.key});

  @override
  _Histogram createState() => _Histogram();

}
class _Histogram extends State<Histogram> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1000.0,
        height: 300.0,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: Alignment(0.0, -0.72),
            image: NetworkImage("http://127.0.0.1:8000/image/"),
          ),
        ),
        child: const Text("Histogram: ", style: TextStyle(fontWeight: FontWeight.bold,)));
  }
}

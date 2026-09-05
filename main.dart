import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CanvasData canvasData = CanvasData(
    height: 1600 / 3,
    width: 900 / 3,
    borderWidth : 5,
    backgroundColor: Colors.amber,
    borderColor : Colors.black
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: ConfiguredCanvas(canvasData: canvasData)),
      ),
    );
  }
}

class CanvasData {
  double height;
  double width;
  double borderWidth ;
  Color backgroundColor;
  Color borderColor ;

  CanvasData({
    required this.height,
    required this.width,
    required this.borderWidth,
        required this.backgroundColor,
    required this.borderColor
  });
}

class ConfiguredCanvas extends StatelessWidget {
  final CanvasData canvasData;

  ConfiguredCanvas({required this.canvasData});

  Widget build(BuildContext context) {
    return Container(
      height: canvasData.height,
      width: canvasData.width,
      decoration: BoxDecoration(
        color: canvasData.backgroundColor,
        border: Border.all(
          color: canvasData.borderColor, // Border color
          width: canvasData.borderWidth, //3.0, // Border width
          style: BorderStyle.solid, // Default is solid
        ),
      ),
      //color: canvasData.backgroundColor,
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CanvasData canvasData = CanvasData(
    height: 1600 / 3,
    width: 900 / 3,
    backgroundColor: Colors.yellow,
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
  Color backgroundColor;

  CanvasData({
    required this.height,
    required this.width,
    required this.backgroundColor,
  });
}

class ConfiguredCanvas extends StatelessWidget {
  final CanvasData canvasData;

  ConfiguredCanvas({required this.canvasData});

  Widget build(BuildContext context) {
    return Container(
      height: canvasData.height,
      width: canvasData.width,
      color: canvasData.backgroundColor,
    );
  }
}


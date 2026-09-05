import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: canvas)),
    );
  }
}

//0 const Map<String, int> gameConfig = { "height" : 800, "width" : 450 };

//1 const Map<String, double> gameConfig = { "height" : 800, "width" : 450, "color" : Colors.yellow };

class CanvasConfig{
  double height;
  double width;
  Color backgroundColor ;
  
  CanvasConfig( { required this.height, required this.width, required this.backgroundColor } );
}

//1 final Container canvas = Container( height : (gameConfig["height"]!), width : (gameConfig["width"]!));

final canvasConfig = CanvasConfig( height : 800, width : 450, backgroundColor : Colors.yellow );
final Container canvas = Container( height : canvasConfig.height, width : canvasConfig.width, color : canvasConfig.backgroundColor );

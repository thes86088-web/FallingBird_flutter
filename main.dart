import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CanvasData canvasData = CanvasData(
    height: 1600 / 3,
    width: 900 / 3,
    borderWidth: 5,
    backgroundColor: Colors.amber,
    borderColor: Colors.black,
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
  double borderWidth;
  Color backgroundColor;
  Color borderColor;

  CanvasData({
    required this.height,
    required this.width,
    required this.borderWidth,
    required this.backgroundColor,
    required this.borderColor,
  });
}

class ConfiguredCanvas extends StatelessWidget {
  final CanvasData canvasData;

  ConfiguredCanvas({required this.canvasData});

  Widget build(BuildContext context) {
    return Container(
      child: BackgroundWidget(),

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

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  //const int TIMERLIMIT = 5 ;
  static const int TIMERLIMIT = 5;

  Timer? _timer;
  int _secondsLeft = TIMERLIMIT;

  void _startTimer() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _secondsLeft = TIMERLIMIT;
          //_timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    // ALWAYS cancel the timer when the widget is destroyed to prevent memory leaks
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _secondsLeft > 0 ? '$_secondsLeft' : 'Done!',
          style: const TextStyle(fontSize: 48),
        ),
        ElevatedButton(
          onPressed: _startTimer,
          child: const Text('Start Countdown'),
        ),
        ElevatedButton(onPressed: dispose, child: const Text('End Countdown')),
      ],
    );
  }
}

class Clouds extends StatelessWidget {
  final List<List<int>> cloudMatrixState;

  Clouds({required this.cloudMatrixState});

  Widget build(BuildContext context) {
    int cols = cloudMatrixState[0].length;
    int rows = cloudMatrixState.length;
    ;
    return GridView.count(
      crossAxisCount: cols, //3, // Number of columns in the matrix
      //padding: const EdgeInsets.all(8.0),
      //mainAxisSpacing: 4.0, // Space between rows
      //crossAxisSpacing: 4.0, // Space between columns
      children: List.generate((cols) * (rows), (index) {
        return Container(
          color: cloudMatrixState[index % cols][index] == 1
              ? Colors.white
              : Colors.transparent, //Colors.blue[100],
          child: Center(child: Text('Cell $index')),
        );
      }),
    );
  }
}

/*
class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key}) : super(key: key);

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  int _secondsLeft = 10;

  void _startTimer() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel(); 
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          // Stop the timer when it reaches 0
          _timer?.cancel(); 
        }
      });
    });
  }

  @override
  void dispose() {
    // ALWAYS cancel the timer when the widget is destroyed to prevent memory leaks
    _timer?.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _secondsLeft > 0 ? '$_secondsLeft' : 'Done!',
          style: const TextStyle(fontSize: 48),
        ),
        ElevatedButton(
          onPressed: _startTimer,
          child: const Text('Start Countdown'),
        ),
      ],
    );
  }
}
*/

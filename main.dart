import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CanvasData canvasData = CanvasData(
    height: 1600 / 3,
    width: 400,  //900 / 3,
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

class Cloud extends StatelessWidget {
  final CloudData cloudData;

  Cloud({required this.cloudData});

  Widget build(BuildContext context) {
    int cols = CloudData.cloudWidth;
    int rows = CloudData.cloudLength;
    int size = CloudData.cloudUnitSize ;

    return GridView.count(
      crossAxisCount: cols, //3, // Number of columns in the matrix
      //padding: const EdgeInsets.all(8.0),
      //mainAxisSpacing: 4.0, // Space between rows
      //crossAxisSpacing: 4.0, // Space between columns
      children: List.generate((cols) * (rows), (index) {
        return Container(
          height : size*1.0,
          width : size*1.0,
          color: cloudData.cloudData[index % cols][index] == 1
              ? Colors.white
              : Colors.transparent, //Colors.blue[100],
          //child: Center(child: Text('Cell $index')),
        );
      }),
    );
  }
}

class CloudData {
  final List<List<int>> cloudData  ;
  static final int cloudLength = 4;
  static final int cloudWidth = 4 ;
  static final int cloudUnitSize = 4 ;
  CloudData( { required this.cloudData } );
  
  static CloudData randomCloudData( ){
    List<List<int>> result = [] ;
    
    const int PRIME_1 = 11 ;
    const int PRIME_2 = 13 ;
    
    for( int row = 0; row < cloudLength ; row++ ){
      List<int> tempRow = [] ;
      for( int col = 0; col < cloudLength ; col++ ){
         int value = ( (col + ( row*PRIME_1 ))*PRIME_2)%2 ;
        tempRow.add( value );
      }
      result.add( tempRow );
    }
     
    return CloudData( cloudData : result );
  }
  
}
  int screenWidth = 400 ;
class SkyData {
  final List<CloudData> cloudList ;
  //static final int cloudCount = 10 ;

  static final int cloudCount = (screenWidth/( CloudData.cloudUnitSize * CloudData.cloudWidth )).floor() ;
  
  SkyData({ required this.cloudList });
  
  static SkyData randomSkyData(){
    List<CloudData> result = [];
    
    for( int count = 0; count < cloudCount ; count++ ){
      result.add( CloudData.randomCloudData() );
    }
    
    return SkyData( cloudList : result );
  }
  
  /*
  void addWithNextCloud(){
    List<CloudData> newCloudList = cloudList.sublist( 1 ) ;
    CloudData newCloud = CloudData.randomCloudData();
    newCloudList.add( newCloud );
    cloudList = newCloudList ;
  }
  */
  
}

class SkyDataToSky extends StatelessWidget{
  
  final SkyData skyData ;
  
  SkyDataToSky({ required this.skyData });
  
    Widget build(BuildContext context) {
      List<Cloud> cloudWidgetList = [] ;
      
      for( int cloudIndex = 0; cloudIndex < SkyData.cloudCount ; cloudIndex++ ){
        CloudData tempCloudData = skyData.cloudList[ cloudIndex ] ;
        cloudWidgetList.add( Cloud( cloudData : tempCloudData ) );
      }
      
      
      return Row( children : cloudWidgetList );
  }

  
}



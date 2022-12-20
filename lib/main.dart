import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0 ;
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        if(_isNear){
          counter++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(centerTitle: true,
          title: const Text('Proximity Sensor Project'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/PROX SENSOR.jpg',),
              SizedBox(
                height: 20.0,
              ),

              _isNear?Text("Proximity Sensor On \n" + "Push Ups Count = " + counter.toString() , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold ,color: Colors.deepOrangeAccent),)
                  :Text("Proximity Sensor Off  \n" + "Push Ups Count =" +  counter.toString(), style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold ,color: Colors.black)),
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(decoration: BoxDecoration(shape: BoxShape.rectangle ,color: Colors.deepOrangeAccent,borderRadius: BorderRadiusDirectional.circular(40)),
                        child: IconButton(onPressed: (){
                          setState(() {
                            counter= 0 ;
                          });
                        }, icon: Icon(Icons.reset_tv))),
                  ],
                ),),
              SizedBox(
                height: 10.0,
              ),
              Text("Reset" , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15.0)),
            ]),
        ),
      ),
    );
  }
}


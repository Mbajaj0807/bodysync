import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'Services/weight_graph.dart';



class ProgressTracking extends StatefulWidget {
  const ProgressTracking({super.key});
  @override
  State<ProgressTracking> createState() => _ProgressTrackingState();
}


class _ProgressTrackingState extends State<ProgressTracking> {
  late Stream<StepCount> _stepCountStream;
  int _steps=0;

  @override
  void initState(){
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async{
    PermissionStatus status=await Permission.activityRecognition.request();

    if(status.isGranted){
      _startListening();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Permission to track steps."),
        action: SnackBarAction(label: "Settings", onPressed: openAppSettings),
      ));
    }
  }

  void _startListening(){
    _stepCountStream=Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event){
    setState(() {
      _steps=event.steps;
    });

  }

  void onStepCountError(error){
    print("Step count error: $error");

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
        backgroundColor: Color.fromRGBO(137, 108, 254, 1),
      ),
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Weight Progress",style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            const SizedBox(height:10),
            SizedBox(height:250,child:WeightGraph()),

            const SizedBox(height: 30),
            const Text("Live Step Count",style: TextStyle(fontSize: 18,color: Colors.white),),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Steps Taken Today: $_steps',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        )
      )
    );
  }
}








import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StatCard extends StatefulWidget {
  @override
  _StatCardState createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  int _steps = 0;  // Variable to store steps

  late Stream<StepCount> _stepCountStream;  // Stream to listen for step count changes

  @override
  void initState() {
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






  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        color: const Color.fromARGB(35, 35, 35, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Today's Stats",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    '52🔥',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(137, 108, 245, 1),
                        Color.fromRGBO(35, 35, 35, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/sneaker.png', height: 35, width: 100),
                      Text(
                        '$_steps',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(137, 108, 245, 1),
                        Color.fromRGBO(35, 35, 35, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/cal.png', height: 30, width: 100),
                      Text(
                        '500',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(137, 108, 245, 1),
                        Color.fromRGBO(35, 35, 35, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/sleep.png', height: 30, width: 100),
                      Text(
                        'Device Not Found',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

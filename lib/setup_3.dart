import 'package:bodysync/setup_2.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/launch_page.dart';
enum Goal { loseweight, gainweight,musclemassgain,tonedbody }



class SetUp3 extends StatefulWidget {
  const SetUp3({super.key});
  @override
  State<SetUp3> createState() => _SetUp3State();
}


class _SetUp3State extends State<SetUp3> {
  Goal? _selectedGoal;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(35, 35, 35, 1),
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100,left:5),
                child: Text("Let Us Help You",style: TextStyle(color: Color.fromRGBO(226, 241, 99, 1),fontSize: 30),textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(137, 108, 254, 1)
                      ,borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25,left:20),
                        child: Align( // Wrap the Text widget with Align
                          alignment: Alignment.centerLeft, // Align to the left
                          child: Text(
                            "What is your goal?",
                            style: TextStyle(
                              color: const Color.fromRGBO(249, 249, 249, 1),
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left, // Keep this for internal text alignment
                          ),
                        ),
                      ),
                      RadioListTile(
                          title:const Text("Lose Weight",style: TextStyle(color: Colors.white,fontSize: 22),),
                          value: Goal.loseweight,
                          groupValue: _selectedGoal,
                          onChanged: (Goal? value){
                            setState(() {
                              _selectedGoal=value;
                            });

                          },
                          activeColor: Color.fromRGBO(226, 241, 99, 1)),
                      RadioListTile(
                          title:const Text("Gain Weight",style: TextStyle(color: Colors.white,fontSize: 22),),
                          value: Goal.gainweight,
                          groupValue: _selectedGoal,
                          onChanged: (Goal? value){
                            setState(() {
                              _selectedGoal=value;
                            });

                          },
                          activeColor: Color.fromRGBO(226, 241, 99, 1)),
                      RadioListTile(
                          title:const Text("Muscle Mass Gain",style: TextStyle(color: Colors.white,fontSize: 22),),
                          value: Goal.musclemassgain,
                          groupValue: _selectedGoal,
                          onChanged: (Goal? value){
                            setState(() {
                              _selectedGoal=value;
                            });

                          },
                          activeColor: Color.fromRGBO(226, 241, 99, 1)),
                      RadioListTile(
                          title:const Text("Toned Body",style: TextStyle(color: Colors.white,fontSize: 22),),
                          value: Goal.tonedbody,
                          groupValue: _selectedGoal,
                          onChanged: (Goal? value){
                            setState(() {
                              _selectedGoal=value;
                            });

                          },
                          activeColor: Color.fromRGBO(226, 241, 99, 1)),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30,left:20),
                child: Align( // Wrap the Text widget with Align
                  alignment: Alignment.centerLeft, // Align to the left
                  child: Text(
                    "Whether you're a beginner or a trained professional. We're here to help you with your fitness journey.",
                    style: TextStyle(
                      color: const Color.fromRGBO(249, 249, 249, 1),
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left, // Keep this for internal text alignment
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:65),
                child: SizedBox
                  (height: 60,width: 350,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LaunchPage()),
                      );
                    },style: ElevatedButton.styleFrom(backgroundColor:const Color.fromRGBO(249, 249, 249, 1) , side: BorderSide(color: Colors.white,width: 1.5)), child: Text("Beginner",style: TextStyle(fontSize: 25,color: Color.fromRGBO(137, 108, 254, 1))),)),
              ),

              Padding(
                padding: const EdgeInsets.only(top:40),
                child: SizedBox
                  (height: 60,width: 350,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LaunchPage()),
                      );
                    },style: ElevatedButton.styleFrom(backgroundColor:const Color.fromRGBO(249, 249, 249, 1) , side: BorderSide(color: Colors.white,width: 1.5)), child: Text("Intermediate",style: TextStyle(fontSize: 25,color: Color.fromRGBO(137, 108, 254, 1))),)),
              ),

              Padding(
                padding: const EdgeInsets.only(top:40),
                child: SizedBox
                  (height: 60,width: 350,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LaunchPage()),
                      );
                    },style: ElevatedButton.styleFrom(backgroundColor:const Color.fromRGBO(249, 249, 249, 1) , side: BorderSide(color: Colors.white,width: 1.5)), child: Text("Advanced",style: TextStyle(fontSize: 25,color: Color.fromRGBO(137, 108, 254, 1))),)),
              ),









            ],
          ),
        )
    );
  }
}


import 'package:flutter/material.dart';
import 'setup_3.dart';
enum Gender { male, female }



class SetUp2 extends StatefulWidget {
  const SetUp2({super.key});
  @override
  State<SetUp2> createState() => _SetUp2State();
}
class _SetUp2State extends State<SetUp2> {
  Gender? _selectedGender;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(35, 35, 35, 1),
        body:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100,left:5),
              child: Text("Fill Your Details Below",style: TextStyle(color: Color.fromRGBO(226, 241, 99, 1),fontSize: 30),textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,left:20),
              child: Align( // Wrap the Text widget with Align
                alignment: Alignment.centerLeft, // Align to the left
                child: Text(
                  "What is your gender?",
                  style: TextStyle(
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left, // Keep this for internal text alignment
                ),
              ),
            ),
            RadioListTile(
              title:const Text("Male",style: TextStyle(color: Colors.white,fontSize: 22),),
              value: Gender.male,
              groupValue: _selectedGender,
              onChanged: (Gender? value){
                setState(() {
                  _selectedGender=value;
                });

              },
              activeColor: Color.fromRGBO(137, 108, 254, 1),),
            RadioListTile(
              title:const Text("Female",style: TextStyle(color: Colors.white,fontSize: 22),),
              value: Gender.female,
              groupValue: _selectedGender,
              onChanged: (Gender? value){
                setState(() {
                  _selectedGender=value;
                });

              },
              activeColor: Color.fromRGBO(137, 108, 254, 1),),
            Padding(
              padding: const EdgeInsets.only(top: 40,left:20),
              child: Align( // Wrap the Text widget with Align
                alignment: Alignment.centerLeft, // Align to the left
                child: Text(
                  "How old are you?",
                  style: TextStyle(
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left, // Keep this for internal text alignment
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10,left:20,right:100),
              child: SizedBox(
                width: 450,
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(137,108,254,1))),
                      border: OutlineInputBorder(),
                      labelText: 'Enter age',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(249, 249, 249, 1),
                      )


                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40,left:20),
              child: Align( // Wrap the Text widget with Align
                alignment: Alignment.centerLeft, // Align to the left
                child: Text(
                  "What is your weight?",
                  style: TextStyle(
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left, // Keep this for internal text alignment
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10,left:20,right:100),
              child: SizedBox(
                width: 450,
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(137,108,254,1))),
                      border: OutlineInputBorder(),
                      labelText: 'Enter weight in kg',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(249, 249, 249, 1),
                      )


                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40,left:20),
              child: Align( // Wrap the Text widget with Align
                alignment: Alignment.centerLeft, // Align to the left
                child: Text(
                  "What is your height?",
                  style: TextStyle(
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left, // Keep this for internal text alignment
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10,left:20,right:100),
              child: SizedBox(
                width: 450,
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(137,108,254,1))),
                      border: OutlineInputBorder(),
                      labelText: 'Enter height in cm',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(249, 249, 249, 1),
                      )


                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:65),
              child: SizedBox
                (height: 50,width: 180,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SetUp3()),
                    );
                  },style: ElevatedButton.styleFrom(backgroundColor:const Color.fromRGBO(35, 35, 35, 1) , side: BorderSide(color: Colors.white,width: 1.5)), child: Text("Next",style: TextStyle(fontSize: 20,color: Colors.white)),)),
            )



          ],
        )
    );
  }
}
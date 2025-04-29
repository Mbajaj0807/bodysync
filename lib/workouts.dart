import 'package:flutter/material.dart';

class Workouts extends StatelessWidget{
  final List<String> bodyParts = [
    'Head', 'Chest', 'Back', 'Arms', 'Legs', 'Shoulders', 'Abdomen', 'Hips', 'Neck', 'Feet'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:  Color.fromRGBO(35,35,35,1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(137, 108, 254, 1),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('Body Parts',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);  // This will navigate back to the previous screen
            },
          ),
        ),
        body: ListView.builder(
          itemCount: bodyParts.length,  // Number of items in the list
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 178, 151, 228),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(

                contentPadding: EdgeInsets.all(25),
                title: Text(
                  bodyParts[index],  // Displaying body part name
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Exercises and info for ${bodyParts[index]}',style: TextStyle(fontSize: 18),),
                trailing: Icon(Icons.fitness_center,size: 40,),  // Optional icon
                onTap: () {
                  // You can add navigation or action when tapped on a body part
                  print('${bodyParts[index]} tapped');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
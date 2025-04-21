import 'package:flutter/material.dart';

class DailyQuizCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        color: const Color.fromRGBO(137, 108, 254, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset('assets/Quiz.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}

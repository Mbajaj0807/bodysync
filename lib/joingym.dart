import 'package:bodysync/widgets/gym_features.dart';
import 'package:flutter/material.dart';

class JoinGym extends StatelessWidget {
  const JoinGym({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      appBar: AppBar(
        title: const Text('Join Gym'),
        backgroundColor: const Color.fromRGBO(137, 108, 254, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(137, 108, 254, 1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Join Your Gym and get all features and benefits at one place',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(226, 241, 99, 1),
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      // Navigate to the gym joining page or perform any action
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(137, 108, 254, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Join Now',
                        style: TextStyle(
                          color: Color.fromRGBO(226, 241, 99, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 100),
          Text(
            'Are You a Gym Owner? \n List Your Gym on bodysync and get all your management done by us',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(226, 241, 99, 1),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              GymFeatures.show(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(137, 108, 254, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'List Your Gym',
                style: TextStyle(
                  color: Color.fromRGBO(226, 241, 99, 1),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

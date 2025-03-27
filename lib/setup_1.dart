import 'package:bodysync/setup_2.dart';
import 'package:flutter/material.dart';

class SetUp extends StatelessWidget {
  const SetUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),

      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,

                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/setup_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                "Consistency Is\n The Key To Progress. \nDon't Give Up!",
                style: TextStyle(
                  color: Color.fromRGBO(226, 241, 99, 1),
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(179, 160, 255, 1),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Remember, consistency is the key to progress. Even on days you don't feel like it, showing up for yourself matters. Keep going!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SizedBox(
                height: 50,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SetUp2()),
                    );
                    print("Next page");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                    side: BorderSide(color: Colors.white, width: 1.5),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(137, 108, 254, 1)),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: Center(
        child: Text(
          'Aishani will make this page!!!',
          style: TextStyle(
            color: Color.fromRGBO(137, 108, 254, 1),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

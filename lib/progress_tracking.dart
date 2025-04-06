import 'package:flutter/material.dart';
import 'Services/weight_graph.dart';

class ProgressTracking extends StatelessWidget {
  const ProgressTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(137, 108, 254, 1)),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Center(
          child: Column(
            children: [SizedBox(height: 300, child: WeightGraph())],
          ),
        ),
      ),
    );
  }
}

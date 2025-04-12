import 'package:bodysync/Workout/abs.dart';
import 'package:bodysync/Workout/back.dart';
import 'package:bodysync/Workout/bicep.dart';
import 'package:bodysync/Workout/legs.dart';
import 'package:bodysync/Workout/tricep.dart';
import 'package:bodysync/Workout/shoulders.dart';
import 'package:bodysync/Workout/chest.dart';

import 'package:flutter/material.dart';

class ClickableBody extends StatelessWidget {
  final void Function(String bodyPart) onPartTap;

  const ClickableBody({super.key, required this.onPartTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        Offset localPosition = details.localPosition;
        String part = _detectBodyPart(localPosition);
        onPartTap(part);
        _handleTapOnBodyPart(part, context);
      },
      child: Stack(
        children: [
          Image.asset(
            'assets/model.png',
            fit: BoxFit.contain,
            width: 427,
            height: 389,
          ),
        ],
      ),
    );
  }

  String _detectBodyPart(Offset position) {
    final dx = position.dx;
    final dy = position.dy;

    if (_isInRegion(dx, dy, 0.246018, 0.266568, 0.156978, 0.070692)) {
      return 'Chest';
    }
    if (_isInRegion(dx, dy, 0.252727, 0.401325, 0.138194, 0.154639)) {
      return 'Abs';
    }
    if (_isInRegion(dx, dy, 0.742443, 0.348306, 0.138194, 0.195876)) {
      return 'Back';
    }
    if (_isInRegion(dx, dy, 0.256081, 0.751105, 0.209304, 0.459499)) {
      return 'Legs';
    }
    if (_isInRegion(dx, dy, 0.125266, 0.308542, 0.063059, 0.110457) ||
        _isInRegion(dx, dy, 0.385554, 0.303387, 0.081843, 0.100147)) {
      return 'Bicep';
    }
    if (_isInRegion(dx, dy, 0.607603, 0.323270, 0.091235, 0.113402) ||
        _isInRegion(dx, dy, 0.892042, 0.318851, 0.107335, 0.110457)) {
      return 'Tricep';
    }
    if (_isInRegion(dx, dy, 0.751835, 0.201031, 0.293830, 0.086892) ||
        _isInRegion(dx, dy, 0.242664, 0.198822, 0.257604, 0.047128)) {
      return 'Shoulder';
    }

    return 'Unknown';
  }

  bool _isInRegion(
    double dx,
    double dy,
    double bx,
    double by,
    double width,
    double height,
  ) {
    final scaleX = 427.0;
    final scaleY = 389.0;

    double x = bx * scaleX;
    double y = by * scaleY;
    double rectWidth = width * scaleX;
    double rectHeight = height * scaleY;

    return dx >= x - rectWidth / 2 &&
        dx <= x + rectWidth / 2 &&
        dy >= y - rectHeight / 2 &&
        dy <= y + rectHeight / 2;
  }

  // Handle tap for each body part
  void _handleTapOnBodyPart(String part, BuildContext context) {
    switch (part) {
      case 'Chest':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ChestWorkout(), // Replace with the actual target page
          ),
        );

        break;
      case 'Abs':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    AbsWorkout(), // Replace with the actual target page
          ),
        );

        break;
      case 'Back':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    BackWorkout(), // Replace with the actual target page
          ),
        );

        break;
      case 'Legs':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    LegsWorkout(), // Replace with the actual target page
          ),
        );

        break;
      case 'Bicep':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    BicepsWorkout(), // Replace with the actual target page
          ),
        );

        break;
      case 'Tricep':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    TricepsWorkout(), // Replace with the actual target page
          ),
        );

        break;
      case 'Shoulder':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ShouldersWorkout(), // Replace with the actual target page
          ),
        );

        break;
      default:
        // Optional: Handle unknown body part
        break;
    }
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    requestPermission(); // Call your async function from here
  }

  Future<void> requestPermission() async {
    PermissionStatus perm = Platform.isAndroid
        ? await Permission.activityRecognition.request()
        : await Permission.sensors.request();

    print('perm: $perm');

    if (perm.isDenied || perm.isPermanentlyDenied || perm.isRestricted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You need to approve the permissions to use the pedometer',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onError,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          action: SnackBarAction(
            label: 'Settings',
            textColor: Theme.of(context).colorScheme.onError,
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    } else {
      // Call your pedometer or step count logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Checking permission...")),
    );
  }
}

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class StepTrackerService {
  static final StepTrackerService _instance = StepTrackerService._internal();
  factory StepTrackerService() => _instance;

  StepTrackerService._internal();

  late Stream<StepCount> _stepCountStream;
  final StreamController<int> _stepController = StreamController<int>.broadcast();
  Stream<int> get stepStream => _stepController.stream;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    PermissionStatus status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(
            (event) => _stepController.add(event.steps),
        onError: (error) => print("Step count error: $error"),
      );
      _initialized = true;
    } else {
      print("Step count permission denied");
    }
  }
}

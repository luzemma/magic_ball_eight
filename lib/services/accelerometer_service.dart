import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerService {
  AccelerometerService()
      : _subscription = userAccelerometerEvents.listen(
          (event) => event,
          cancelOnError: true,
        );
  final StreamSubscription<UserAccelerometerEvent> _subscription;

  StreamSubscription<UserAccelerometerEvent> listen() {
    return _subscription;
  }

  Future<void> close() async {
    await _subscription.cancel();
  }
}

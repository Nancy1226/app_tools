import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccelerometerEvent>(
      stream: accelerometerEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Text('Acelerómetro: ${snapshot.data}'),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

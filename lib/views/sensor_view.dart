import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensores'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Acelerómetro
          StreamBuilder<AccelerometerEvent>(
            stream: accelerometerEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Acelerómetro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('X: ${snapshot.data!.x.toStringAsFixed(2)}'),
                        Text('Y: ${snapshot.data!.y.toStringAsFixed(2)}'),
                        Text('Z: ${snapshot.data!.z.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),

          // Giroscopio
          StreamBuilder<GyroscopeEvent>(
            stream: gyroscopeEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Giroscopio', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('X: ${snapshot.data!.x.toStringAsFixed(2)}'),
                        Text('Y: ${snapshot.data!.y.toStringAsFixed(2)}'),
                        Text('Z: ${snapshot.data!.z.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),

          // Magnetómetro
          StreamBuilder<MagnetometerEvent>(
            stream: magnetometerEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Magnetómetro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('X: ${snapshot.data!.x.toStringAsFixed(2)} μT'),
                        Text('Y: ${snapshot.data!.y.toStringAsFixed(2)} μT'),
                        Text('Z: ${snapshot.data!.z.toStringAsFixed(2)} μT'),
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

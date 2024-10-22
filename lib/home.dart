import 'dart:convert';
import 'package:flutter/material.dart';
import './screens/geolocator.dart'; 
import './screens/qr_code.dart'; 
import './screens/sensor_mobile.dart'; 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const GeolocatorApp()),
                );
              },
              child: const Text('Geolocalizacion'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QrCodeScanner()),
                );
              },
              child: const Text('Leer codigo qr'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const JuegoDeEquilibrio()),
                );
              },
              child: const Text('Sensor del celular'),
            ),
          ],
        ),
      ),
    );
  }
}
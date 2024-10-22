import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const GeolocatorApp());
}

class GeolocatorApp extends StatelessWidget {
  const GeolocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _locationMessage;

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permissions are denied";
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    String url =
        "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";

    setState(() {
      _locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });

    // Abre el enlace en el navegador
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocalización'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Obtener ubicación'),
            ),
            if (_locationMessage != null) ...[
              const SizedBox(height: 20),
              Text(_locationMessage!),
            ],
          ],
        ),
      ),
    );
  }
}

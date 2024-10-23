import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class GeoView extends StatelessWidget {
  const GeoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocalización'),
      ),
      body: const LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {
  String? locationMessage;
  Position? currentPosition;
  bool isLoading = false;

  Future<void> getCurrentLocation() async {
    setState(() {
      isLoading = true;
      locationMessage = "Obteniendo ubicación...";
    });

    try {
      // Verificar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationMessage = "Los permisos de ubicación fueron denegados";
            isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          locationMessage = "Los permisos de ubicación están permanentemente denegados";
          isLoading = false;
        });
        return;
      }

      // Obtener la posición actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentPosition = position;
        locationMessage = """
        Latitud: ${position.latitude}
        Longitud: ${position.longitude}
        Altitud: ${position.altitude}
        Velocidad: ${position.speed} m/s
        Precisión: ${position.accuracy} metros""";
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        locationMessage = "Error al obtener la ubicación: $e";
        isLoading = false;
      });
    }
  }

  Future<void> openInMaps() async {
    if (currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Primero obtén tu ubicación'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Crear la URL de Google Maps
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${currentPosition!.latitude},${currentPosition!.longitude}',
    );
    
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      )) {
        throw 'No se pudo abrir el mapa';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al abrir el mapa: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: isLoading ? null : getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: Text(isLoading ? 'Obteniendo ubicación...' : 'Obtener ubicación'),
            ),
            const SizedBox(height: 20),
            if (locationMessage != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        locationMessage!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      if (currentPosition != null) ...[
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: openInMaps,
                          icon: const Icon(Icons.map),
                          label: const Text('Abrir en Google Maps'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
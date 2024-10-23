import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'views/sensor_view.dart';
import 'views/geo_view.dart';
import 'views/info_view.dart';
import 'views/qr_view.dart';
import 'views/speech_to_text_view.dart';
import 'views/text_to_speech_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Herramientas del Teléfono',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    InfoView(),
    GeoView(),
    QRView(),
    SensorView(),
    SpeechToTextView(),
    TextToSpeechView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aplicación Multi-Funcional')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue, // Color para iconos seleccionados
        unselectedItemColor: Color(0xFF7D8DA1), // Color para iconos no seleccionados
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'GPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Sensores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Speech',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volume_up),
            label: 'TTS',
          ),
        ],
      ),
    );
  }
}

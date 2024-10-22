import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Equilibrio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JuegoDeEquilibrio(),
    );
  }
}

class JuegoDeEquilibrio extends StatefulWidget {
  const JuegoDeEquilibrio({super.key});

  @override
  _JuegoDeEquilibrioState createState() => _JuegoDeEquilibrioState();
}

class _JuegoDeEquilibrioState extends State<JuegoDeEquilibrio> {
  double _bolaY = 0.0;
  double _bolaVelocidadY = 2.0; // Reducida la velocidad inicial de caída
  double _bolaPosicionX = 0.0;
  double _barraPosicionX = 0.0;
  double _barraAncho = 100.0;
  double _altoPantalla = 0.0;
  double _anchoPantalla = 0.0;
  bool _juegoTerminado = false;
  Timer? _timer;

  void _iniciarJuego() {
    setState(() {
      _bolaY = 0.0;
      _bolaPosicionX = Random().nextDouble() * (_anchoPantalla - 50);
      _barraPosicionX = (_anchoPantalla - _barraAncho) / 2;
      _juegoTerminado = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_juegoTerminado) {
        timer.cancel();
        return;
      }
      _actualizarEstado();
    });

    accelerometerEvents.listen((event) {
      _actualizarBarra(event);
    });
  }

  void _actualizarEstado() {
    setState(() {
      _bolaY += _bolaVelocidadY;
      _bolaVelocidadY += 0.1; // Añadir gravedad

      // Comprobar colisión con la barra
      if (_bolaY + 50 >= _altoPantalla - 50 &&
          _bolaY + 50 <= _altoPantalla - 30 &&
          _bolaPosicionX + 25 >= _barraPosicionX &&
          _bolaPosicionX + 25 <= _barraPosicionX + _barraAncho) {
        _bolaY = _altoPantalla - 80; // Colocar la bola justo encima de la barra
        _bolaVelocidadY = -_bolaVelocidadY * 0.8; // Invertir y reducir la velocidad (efecto de rebote)
      }

      // Verificar si la bola cae al fondo
      if (_bolaY >= _altoPantalla - 50) {
        _juegoTerminado = true;
      }

      // Rebotar en los lados
      if (_bolaPosicionX <= 0 || _bolaPosicionX >= _anchoPantalla - 50) {
        _bolaPosicionX = _bolaPosicionX <= 0 ? 0 : _anchoPantalla - 50;
      }
    });
  }

  void _actualizarBarra(AccelerometerEvent event) {
    setState(() {
      _barraPosicionX += event.x * 2; // Ajusta la sensibilidad
      _barraPosicionX = _barraPosicionX.clamp(0, _anchoPantalla - _barraAncho);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _altoPantalla = MediaQuery.of(context).size.height;
      _anchoPantalla = MediaQuery.of(context).size.width;
      _iniciarJuego();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Juego de Equilibrio')),
      body: Stack(
        children: [
          // Bola
          Positioned(
            left: _bolaPosicionX,
            top: _bolaY,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
          // Barra
          Positioned(
            left: _barraPosicionX,
            bottom: 30,
            child: Container(
              width: _barraAncho,
              height: 20,
              color: Colors.blue,
            ),
          ),
          // Mensaje de fin de juego
          if (_juegoTerminado)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '¡Juego Terminado!',
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: _iniciarJuego,
                    child: const Text('Reiniciar'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
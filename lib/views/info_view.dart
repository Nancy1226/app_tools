import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir el enlace de GitHub

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  // Función para abrir la URL de GitHub
  Future<void> _launchGitHub() async {
    final Uri url =
        Uri.parse('https://github.com/Nancy1226/app_tools.git');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el enlace $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color accentBlue = Color(0xFF76A0D1);
    const Color darkBackground = Color(0xFFFFFFFF);
    const Color whiteColor = Colors.white;

    return Scaffold(
      backgroundColor: darkBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'asset/img/uplogo.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              // Nombre
              const Text(
                'Nancy Guadalupe Jimenez Escobar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: accentBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Información adicional
              const Text(
                'Ingeniería en Desarrollo de Software',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Programación para Móviles',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: accentBlue,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '221201    9°A',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // Enlace a GitHub
              GestureDetector(
                onTap: _launchGitHub,
                child: const Text(
                  'GitHub',
                  style: TextStyle(
                    color: accentBlue,
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

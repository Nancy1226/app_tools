import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerator extends StatelessWidget {
  const QrCodeGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aquí puedes incluir los datos que quieres codificar en el QR.
    String data = 'Nombre: Nancy Guadalupe Jimenez Escobar\nMatrícula: 221201\nCorreo: 221201@ids.upchicpas.edu.mx';

    return Scaffold(
      appBar: AppBar(title: const Text('Generar Código QR')),
      body: Center(
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
      ),
    );
  }
}
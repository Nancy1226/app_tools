import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'qr_generator.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  _QrCodeScannerState createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String? _qrCodeResult;

  void _showQrCodeResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado del QR'),
          content: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              result,
              key: ValueKey<String>(result),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresar a la página anterior
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  // Comprobar si barcode.rawValue no es null
                  if (barcode.rawValue != null && _qrCodeResult != barcode.rawValue) {
                    setState(() {
                      _qrCodeResult = barcode.rawValue;
                    });

                    // Mostrar el resultado en un AlertDialog
                    _showQrCodeResult(barcode.rawValue!); // Usar el operador ! para asegurar que no es null
                  }
                }
              },
            ),
          ),
          ElevatedButton(
            child: const Text('Generar Código QR'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const QrCodeGenerator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

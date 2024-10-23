import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextView extends StatefulWidget {
  @override
  _SpeechToTextViewState createState() => _SpeechToTextViewState();
}

class _SpeechToTextViewState extends State<SpeechToTextView> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Presiona el botón para empezar a hablar';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_text),
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
            onPressed: _listen,
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (errorNotification) =>
            print('Error: $errorNotification.errorMsg'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                }));
      } else {
        setState(() => _text = 'No se pudo iniciar el reconocimiento de voz');
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

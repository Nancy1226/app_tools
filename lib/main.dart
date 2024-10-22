import 'package:flutter/material.dart';
import 'home.dart'; // Importa la página de inicio

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBot-IA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home', // Ruta inicial
      routes: {
        '/home': (context) => const Home(), // Define la ruta '/home'
      },
    );
  }
}

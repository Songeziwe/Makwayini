import 'package:flutter/material.dart';
import 'package:quicloc/screens/splash.dart';
import 'package:quicloc/screens/home.dart';
import 'package:quicloc/screens/messages.dart';

void main() {
  runApp(const MyApp());
}

// root widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quickloc Mobile Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const Home(),
        '/messages': (context) => const Messages(),
        '/splash': (context) => const Splash(),
      },
    );
  }
}

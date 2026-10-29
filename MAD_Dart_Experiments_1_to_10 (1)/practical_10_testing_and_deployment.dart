// MAD Practical 10: Testing and Deploying a Flutter App on Android
//
// Useful commands (run from the Flutter project directory):
//   flutter doctor
//   flutter pub get
//   flutter analyze
//   flutter test
//   flutter build apk --release
//   flutter build appbundle --release
//
// APK output: build/app/outputs/flutter-apk/app-release.apk
// AAB output: build/app/outputs/bundle/release/app-release.aab
//
// For Play Store deployment, configure secure release signing and app metadata.
// Do not commit passwords or keystore files to a public repository.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Deployment',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Deployment')),
        body: const Center(
          child: Text(
            'Flutter App Successfully Launched!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

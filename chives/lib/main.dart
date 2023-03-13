import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'onboarding/onboarding_one.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chives',
      theme: ThemeData(
        primarySwatch: createMaterialColor(darkGreen),
      ),
      home: const OnboardingOne(),
    );
  }
}

// FirebaseAuth.instance
//   .authStateChanges()
//   .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
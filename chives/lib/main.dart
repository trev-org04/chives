import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'application/manager.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'onboarding/onboarding_one.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isLoggedIn;
  FirebaseAuth instance = FirebaseAuth.instance;
  instance.currentUser != null ? isLoggedIn = true : isLoggedIn = false;
  runApp(Chives(isLoggedIn: isLoggedIn));
}

class Chives extends StatelessWidget {
  final bool isLoggedIn;
  Chives({required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chives',
        theme: ThemeData(
          primarySwatch: createMaterialColor(darkGreen),
        ),
        home: isLoggedIn ? const Manager() : const OnboardingOne());
  }
}

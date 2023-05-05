import 'package:chives/onboarding/onboarding_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreen,
      child: ListView(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            height: 70,
            width: 45,
            child: Image.asset('assets/images/logo.png')),
        Container(
            padding: const EdgeInsets.fromLTRB(25, 35, 45, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'PROFILE',
                  style: TextStyle(
                      color: textWhite,
                      fontSize: 35.0,
                      fontFamily: 'Proxima Nova',
                      letterSpacing: 1.0),
                )
              ],
            )),
        Container(
          decoration: const BoxDecoration(color: offWhite),
          child: TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();

                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => const OnboardingOne()),
                    (route) => false);
              },
              child: const Text('sign out')),
        ),
      ]),
    );
  }
}

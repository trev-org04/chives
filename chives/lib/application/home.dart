import 'package:chives/application/home_widgets/recommended_carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  static final FirebaseAuth instance = FirebaseAuth.instance;
  final User user = instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreen,
      child: ListView(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              height: 70,
              width: 45,
              child: Image.asset('assets/images/logo.png')),
          Container(
              padding: const EdgeInsets.fromLTRB(25, 35, 45, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WELCOME,',
                    style: TextStyle(
                        color: offWhite,
                        fontSize: 22.0,
                        fontFamily: 'Proxima Nova',
                        letterSpacing: 1.0),
                  ),
                  Text(
                    user.displayName.toString().toUpperCase(),
                    style: const TextStyle(
                        color: textWhite,
                        fontSize: 35.0,
                        fontFamily: 'Proxima Nova',
                        letterSpacing: 1.0),
                  )
                ],
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                child: Text(
                  'Recommended For You',
                  style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      color: offWhite,
                      fontSize: 19),
                ),
              ),
              RecommendedCarousel(),
            ],
          )
        ],
      ),
    );
  }
}

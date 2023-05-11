import 'package:chives/onboarding/sign_in.dart';
import 'package:chives/onboarding/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhite,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: darkGreen,
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Image.asset(
                      'assets/images/landing.png',
                      height: 370,
                      width: 360,
                    ),
                  ),
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 60.0, 25.0, 10.0),
                    child: Text(
                      'WELCOME!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: background,
                          fontSize: 22.0,
                          fontFamily: 'Proxima Nova',
                          letterSpacing: 1.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 20.0),
                    child: Text(
                      'Dive into the world of Chives today!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: background,
                          fontSize: 15.0,
                          fontFamily: 'HM Sans'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 45,
                            decoration: const BoxDecoration(
                                color: darkGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(_createSignUpRoute());
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: 'HM Sans',
                                    fontSize: 15.0,
                                    color: textWhite),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 45,
                            decoration: const BoxDecoration(
                                color: offWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(_createSignInRoute());
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontFamily: 'HM Sans',
                                    fontSize: 15.0,
                                    color: background),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                    color: textWhite,
                    borderRadius: BorderRadius.all(Radius.circular(110))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 55,
                    height: 55,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Route _createSignUpRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SignUp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createSignInRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SignIn(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

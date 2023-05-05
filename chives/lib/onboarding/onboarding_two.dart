import 'package:chives/onboarding/landing.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

class OnboardingTwo extends StatefulWidget {
  const OnboardingTwo({super.key});

  @override
  State<OnboardingTwo> createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends State<OnboardingTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhite,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: mediumGreen,
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Image.asset(
                  'assets/images/onboardingTwo.png',
                  height: 400,
                  width: 390,
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
                  'DON\'T SWEAT IT',
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
                  'We\'ve got you covered. Mexican? We\'ve got it. Indian? We\'ve got it. Caribbean? We\'ve got it. Korean? We\'ve got it. Got something else in mind? Trust us, we\'ve got it. ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: background, fontSize: 15.0, fontFamily: 'HM Sans'),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                      child: Row(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            decoration: const BoxDecoration(
                              color: offWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            width: 10,
                            height: 10,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              color: mediumGreen,
                            ),
                            width: 30,
                            height: 10,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: mediumGreen,
                      foregroundColor: offWhite,
                      splashColor: offWhite,
                      child: Image.asset('assets/images/arrowRight.png'),
                      onPressed: () {
                        Navigator.of(context).push(_createRoute());
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Landing(),
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

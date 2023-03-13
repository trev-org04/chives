import 'package:flutter/material.dart';
import 'package:chives/constants.dart';
import 'onboarding_two.dart';

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhite,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: lightGreen,
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Image.asset(
                  'assets/images/onboardingOne.png',
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
                // might need to change padding value for top and bottom to be dynamic
                child: Text(
                  'TIRED OF COOKBOOKS?',
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
                // might need to change padding value for top and bottom to be dynamic
                child: Text(
                  'We are too. That’s why we made Chives, the best cookbook you’ll ever have and it’s right in your pocket. Chives provides you with high-quality recipes for whatever you’re feeling.',
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
                      // might need to change padding value for top and bottom to be dynamic
                      child: Row(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              color: lightGreen,
                            ),
                            width: 30,
                            height: 10,
                          ),
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
                            decoration: const BoxDecoration(
                              color: offWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                    child: FloatingActionButton(
                      backgroundColor: lightGreen,
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
    pageBuilder: (context, animation, secondaryAnimation) =>
        const OnboardingTwo(),
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

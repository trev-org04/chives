import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';
import '../application/manager.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "", password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: textWhite,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: textWhite),
            child: Stack(children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: darkGreen,
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Image.asset(
                        'assets/images/signIn.png',
                        height: 400 * .9,
                        width: 390 * .9,
                      ),
                    ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 80.0, 25.0, 10.0),
                        // might need to change padding value for top and bottom to be dynamic
                        child: Text(
                          'WELCOME BACK!',
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
                          'Hop back into the world of Chives!',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: background,
                              fontSize: 15.0,
                              fontFamily: 'HM Sans'),
                        ),
                      ),
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
                            // might need to change padding value for top and bottom to be dynamic
                            child: TextField(
                              onChanged: (value) {
                                email = value;
                                print(email);
                              },
                              style: const TextStyle(
                                  color: background,
                                  fontFamily: 'HM Sans',
                                  fontSize: 15.0),
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  hintStyle: TextStyle(
                                      fontFamily: 'HM Sans',
                                      fontSize: 15.0,
                                      color: inputColor),
                                  border: InputBorder.none),
                            )),
                      ),
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
                            // might need to change padding value for top and bottom to be dynamic
                            child: TextField(
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: true,
                              style: const TextStyle(
                                  color: background,
                                  fontFamily: 'HM Sans',
                                  fontSize: 15.0),
                              decoration: const InputDecoration(
                                  hintText: 'Password',
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  hintStyle: TextStyle(
                                      fontFamily: 'HM Sans',
                                      fontSize: 15.0,
                                      color: inputColor),
                                  border: InputBorder.none),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                25.0, 20.0, 25.0, 0.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: darkGreen,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                // might need to change padding value for top and bottom to be dynamic
                                child: TextButton(
                                  onPressed: () {
                                    signInUser(email, password).then((value) {
                                      if (value == 1) {
                                        Navigator.of(context)
                                            .push(_createRoute());
                                      } else {
                                        print('could not log in');
                                      }
                                    });
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontFamily: 'HM Sans',
                                        fontSize: 15.0,
                                        color: textWhite),
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
            ]),
          ),
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Manager(),
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

Future<int> signInUser(String email, String password) async {
  final auth = FirebaseAuth.instance;
  int isSuccess = 0;
  try {
    final currentUser =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    isSuccess = 1;
  } catch (e) {
    print(e.toString());
  }
  print('isSuccess: ' + isSuccess.toString());
  return isSuccess;
}

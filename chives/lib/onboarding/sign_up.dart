import 'package:chives/application/manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "", email = "", password = "", repeatPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: textWhite,
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 25.0),
          height: MediaQuery.of(context).size.height * 1.25,
          decoration: const BoxDecoration(color: textWhite),
          child: Stack(
            children: [
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
                        'assets/images/signUp.png',
                        height: 400 * .8,
                        width: 390 * .8,
                      ),
                    ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 80.0, 25.0, 10.0),
                        child: Text(
                          'LET\'S GET STARTED!',
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
                          'Only a few steps from the world of Chives!',
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
                            child: TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              style: const TextStyle(
                                  color: background,
                                  fontFamily: 'HM Sans',
                                  fontSize: 15.0),
                              decoration: const InputDecoration(
                                  hintText: 'First Name',
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
                            child: TextField(
                              onChanged: (value) {
                                email = value;
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
                            child: TextField(
                              onChanged: (value) {
                                repeatPassword = value;
                              },
                              obscureText: true,
                              style: const TextStyle(
                                  color: background,
                                  fontFamily: 'HM Sans',
                                  fontSize: 15.0),
                              decoration: const InputDecoration(
                                  hintText: 'Repeat Password',
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
                                25.0, 15.0, 25.0, 0.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: darkGreen,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: TextButton(
                                  onPressed: () {
                                    createNewUser(email, password, name).then(
                                        (value) => Navigator.of(context)
                                            .push(createRoute()));
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
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .2),
                child: Center(
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
        ),
      ]),
    );
  }
}

Route createRoute() {
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

// form validation needs to be done
Future<int> createNewUser(String email, String password, String name) async {
  final auth = FirebaseAuth.instance;
  try {
    final newUser = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await newUser.user?.updateDisplayName(name);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUser.user?.uid)
        .collection('recipes')
        .doc()
        .set({
      'recipe': 000000,
    });
    return 0;
  } catch (e) {
    print("Exceptions Occurred: " + e.toString());
    return -1;
  }
}

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
  String email = "",
      password = "",
      userErrorText = "",
      passErrorText = "",
      lastUserVal = "",
      lastPassVal = "";
  bool failedSignInUser = false;
  bool failedSignInPass = false;
  static var userController = TextEditingController(text: "");
  static var passController = TextEditingController(text: "");
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
            padding: const EdgeInsets.only(bottom: 25.0),
            height: MediaQuery.of(context).size.height + 40,
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
                        child: Text(
                          'Hop back into the world of Chives!',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: background,
                              fontSize: 15.0,
                              fontFamily: 'HM Sans'),
                        ),
                      ),
                      failedSignInUser
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 0.0, 0.0, 0.0),
                              child: Text(
                                userErrorText,
                                style: const TextStyle(
                                    color: errorColor,
                                    fontFamily: 'HM Sans',
                                    fontSize: 12.0),
                              ),
                            )
                          : const SizedBox(),
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
                              controller: userController,
                              onChanged: (value) {
                                email = value;
                                lastUserVal = value;
                              },
                              style: TextStyle(
                                  color: failedSignInUser
                                      ? errorColor
                                      : background,
                                  fontFamily: 'HM Sans',
                                  fontSize: 15.0),
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  contentPadding:
                                      const EdgeInsets.only(left: 15.0),
                                  hintStyle: TextStyle(
                                      fontFamily: 'HM Sans',
                                      fontSize: 15.0,
                                      color: failedSignInUser
                                          ? errorColor
                                          : inputColor),
                                  border: InputBorder.none),
                            )),
                      ),
                      failedSignInPass
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 15.0, 0.0, 0.0),
                              child: Text(
                                passErrorText,
                                style: const TextStyle(
                                    color: errorColor,
                                    fontFamily: 'HM Sans',
                                    fontSize: 12.0),
                              ),
                            )
                          : const SizedBox(),
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
                              controller: passController,
                              onChanged: (value) {
                                password = value;
                                lastPassVal = value;
                              },
                              obscureText: true,
                              style: TextStyle(
                                  color: failedSignInPass
                                      ? errorColor
                                      : background,
                                  fontFamily: 'HM Sans',
                                  fontSize: 15.0),
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding:
                                      const EdgeInsets.only(left: 15.0),
                                  hintStyle: TextStyle(
                                      fontFamily: 'HM Sans',
                                      fontSize: 15.0,
                                      color: failedSignInPass
                                          ? errorColor
                                          : inputColor),
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
                                child: TextButton(
                                  onPressed: () {
                                    signInUser(email, password).then((value) {
                                      if (value == 1) {
                                        Navigator.of(context)
                                            .push(createRoute());
                                      } else if (value == -1) {
                                        setState(() {
                                          userErrorText =
                                              'There is no email associated with this account.';
                                          failedSignInUser = true;
                                          failedSignInPass = false;
                                          userController.text = lastUserVal;
                                          passController.text = lastPassVal;
                                        });
                                      } else if (value == -2) {
                                        setState(() {
                                          userErrorText =
                                              'Please enter a valid email.';
                                          failedSignInUser = true;
                                          failedSignInPass = false;
                                          userController.text = lastUserVal;
                                          passController.text = lastPassVal;
                                        });
                                      } else if (value == -3) {
                                        setState(() {
                                          passErrorText =
                                              'Please enter the correct password for this account.';
                                          failedSignInPass = true;
                                          failedSignInUser = false;
                                          userController.text = lastUserVal;
                                          passController.text = lastPassVal;
                                        });
                                      } else if (value == -4) {
                                        setState(() {
                                          userErrorText =
                                              'Please enter an email.';
                                          passErrorText =
                                              'Please enter a password.';
                                          failedSignInPass = true;
                                          failedSignInUser = true;
                                          userController.text = lastUserVal;
                                          passController.text = lastPassVal;
                                        });
                                      } else if (value == -5) {
                                        setState(() {
                                          userErrorText =
                                              'Please enter an email.';
                                          failedSignInPass = false;
                                          failedSignInUser = true;
                                          userController.text = lastUserVal;
                                          passController.text = lastPassVal;
                                        });
                                      } else if (value == -6) {
                                        setState(() {
                                          passErrorText =
                                              'Please enter a password.';
                                          failedSignInPass = true;
                                          failedSignInUser = false;
                                          userController.text = lastUserVal;
                                          passController.text = lastPassVal;
                                        });
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

Future<int> signInUser(String email, String password) async {
  final auth = FirebaseAuth.instance;
  int isSuccess = 0;
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    isSuccess = 1;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      isSuccess = -1;
    } else if (e.code == "invalid-email") {
      isSuccess = -2;
    } else if (e.code == "wrong-password") {
      isSuccess = -3;
    }
  }
  if (email == "" && password == "") {
    isSuccess = -4;
  } else if (email == "") {
    isSuccess = -5;
  } else if (password == "") {
    isSuccess = -6;
  }
  return isSuccess;
}

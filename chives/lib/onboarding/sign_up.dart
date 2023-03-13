import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

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
          height: MediaQuery.of(context).size.height * 1.15,
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
                        // might need to change padding value for top and bottom to be dynamic
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
                            // might need to change padding value for top and bottom to be dynamic
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
                            // might need to change padding value for top and bottom to be dynamic
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
                                // might need to change padding value for top and bottom to be dynamic
                                child: TextButton(
                                  onPressed: () {
                                    createNewUser(email, password, name);
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
                    bottom: MediaQuery.of(context).size.height * .15),
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

createNewUser(String email, String password, String name) async {
  final auth = FirebaseAuth.instance;
  try {
    final newuser = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await newuser.user?.updateDisplayName(name);
    // if (newuser != null) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => MyLoginPage()),
    //   );
    // }
  } catch (e) {
    print("Exceptions Occurred!" + e.toString());
  }
}

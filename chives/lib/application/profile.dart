import 'package:chives/onboarding/onboarding_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static final FirebaseAuth instance = FirebaseAuth.instance;
  final User user = instance.currentUser!;
  static var nameController = TextEditingController(text: "");
  static var emailController = TextEditingController(text: "");
  bool profileUpdated = false, isEditable = false;
  String editButtonText = "Edit Profile", message = "";

  void setTextFieldInfo() {
    FirebaseAuth instance = FirebaseAuth.instance;
    instance.userChanges().listen((user) {
      if (nameController.text != user?.displayName.toString()) {
        nameController.text = user!.displayName.toString();
      }
      if (emailController.text != user?.email.toString()) {
        emailController.text = user!.email.toString();
      }
    });
  }

  void removeMessage(bool visible) {
    if (visible) {
      Future.delayed(const Duration(seconds: 3)).then((v) {
        setState(() {
          profileUpdated = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setTextFieldInfo();
    removeMessage(profileUpdated);
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
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            decoration: const BoxDecoration(
                color: offWhite,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                    child: Text(
                      'First Name',
                      style: TextStyle(
                        color: background,
                        fontSize: 15.0,
                        fontFamily: 'HM Sans',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: textWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: TextField(
                      enabled: isEditable,
                      controller: nameController,
                      style: TextStyle(
                          color: isEditable ? background : inputColor,
                          fontFamily: 'HM Sans',
                          fontSize: 15.0),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintStyle: TextStyle(
                              fontFamily: 'HM Sans',
                              fontSize: 15.0,
                              color: inputColor),
                          border: InputBorder.none),
                    )),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: background,
                        fontSize: 15.0,
                        fontFamily: 'HM Sans',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 15.0),
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: textWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: TextField(
                      enabled: isEditable,
                      controller: emailController,
                      style: TextStyle(
                          color: isEditable ? background : inputColor,
                          fontFamily: 'HM Sans',
                          fontSize: 15.0),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintStyle: TextStyle(
                              fontFamily: 'HM Sans',
                              fontSize: 15.0,
                              color: inputColor),
                          border: InputBorder.none),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 25.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextButton(
                      onPressed: () async {
                        if (isEditable) {
                          bool hasEdited = false;
                          if (user.displayName
                                  .toString()
                                  .compareTo(nameController.text) !=
                              0) {
                            await user.updateDisplayName(nameController.text);
                            hasEdited = true;
                          }
                          if (user.email
                                  .toString()
                                  .compareTo(emailController.text) !=
                              0) {
                            await user.updateEmail(emailController.text);
                            hasEdited = true;
                          }
                          setState(() {
                            profileUpdated = hasEdited;
                            isEditable = false;
                            editButtonText = "Edit Profile";
                            message = "Your profile has been updated!";
                          });
                        } else {
                          setState(() {
                            profileUpdated = false;
                            isEditable = true;
                            editButtonText = "Save Profile";
                          });
                        }
                      },
                      child: Text(
                        editButtonText,
                        style: const TextStyle(
                          color: textWhite,
                          fontSize: 18.0,
                          fontFamily: 'Proxima Nova Bold',
                        ),
                      )),
                ),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
          child: Container(
            decoration: const BoxDecoration(
                color: errorColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            width: MediaQuery.of(context).size.width - 50,
            child: TextButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.signOut();
                  navigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => const OnboardingOne()),
                      (route) => false);
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 18.0,
                    fontFamily: 'Proxima Nova Bold',
                  ),
                )),
          ),
        ),
        profileUpdated
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: textWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 0.0, 12.5, 0.0),
                          child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: const BoxDecoration(
                                  color: darkGreen,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35.0))),
                              child: const Icon(
                                Icons.check,
                                color: textWhite,
                                size: 17.5,
                              )),
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                            color: background,
                            fontSize: 15.0,
                            fontFamily: 'HM Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ]),
    );
  }
}

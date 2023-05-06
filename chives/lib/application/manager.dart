import 'package:flutter/material.dart';
import 'package:chives/constants.dart';
import 'explore.dart';
import 'home.dart';
import 'profile.dart';

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  int pageIndex = 1;

  final pages = [
    const Explore(),
    Home(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      body: pages[pageIndex],
      bottomNavigationBar: SizedBox(
        height: 85,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            decoration: BoxDecoration(
                color: pageIndex == 0 ? lightGreen : darkGreen,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.explore_rounded,
                      color: darkGreen,
                      size: 30,
                    )
                  : const Icon(
                      Icons.explore_rounded,
                      color: background,
                      size: 30,
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: pageIndex == 1 ? lightGreen : darkGreen,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.home_rounded,
                      color: darkGreen,
                      size: 30,
                    )
                  : const Icon(
                      Icons.home_rounded,
                      color: background,
                      size: 30,
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: pageIndex == 2 ? lightGreen : darkGreen,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.person_rounded,
                      color: darkGreen,
                      size: 30,
                    )
                  : const Icon(
                      Icons.person_rounded,
                      color: background,
                      size: 30,
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}

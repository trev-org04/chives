import 'package:chives/application/home_widgets/recommended_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                child: Text(
                  'Favorite Recipes',
                  style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      color: offWhite,
                      fontSize: 19),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 25,
                  height: 243,
                  child: const FavoriteCarousel()),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                child: Text(
                  'Recommended Recipes',
                  style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      color: offWhite,
                      fontSize: 19),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 25,
                  height: 246,
                  child: const RecommendedCarousel()),
            ],
          )
        ],
      ),
    );
  }
}

class FavoriteCard extends StatefulWidget {
  final int id;
  final String title;
  const FavoriteCard({required this.id, required this.title, super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  String capitalizeItemTitle(String title) {
    String capTitle = "";
    int initIndex = 0, index = 0;
    List<String> words = [], newCapWords = [];

    while (index < title.length) {
      String sub = title.substring(index, index + 1);
      if (sub == " " || index == title.length - 1) {
        if (initIndex == 0) {
          words.add(title.substring(initIndex, index + 1));
        } else {
          words.add(title.substring(initIndex - 1, index + 1));
        }
        initIndex = index + 1;
      }
      index++;
    }
    for (String word in words) {
      Set<String> capWords = {'bbq', 'blt'};
      if (word.substring(0, 1) == " ") {
        word = word.substring(1);
      }
      if (capWords.contains(word)) {
        newCapWords.add(word.toUpperCase());
      } else {
        String firstChar = word.substring(0, 1);
        String endOfWord = word.substring(1);
        newCapWords.add(firstChar.toUpperCase() + endOfWord);
      }
    }
    for (String word in newCapWords) {
      if (word.substring(word.length - 1) == " ") {
        capTitle = "$capTitle$word";
      } else {
        capTitle = "$capTitle$word ";
      }
    }
    return capTitle;
  }

  String reduceTitle(String title) {
    String reducedTitle = title;
    if (title.length >= 23) {
      reducedTitle = '${title.substring(0, 22)}...';
    }
    return reducedTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 15.0),
      child: Container(
          width: MediaQuery.of(context).size.width * .75,
          decoration: const BoxDecoration(
              color: offWhite,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                child: Image.network(
                  "https://spoonacular.com/recipeImages/${widget.id}-312x150.jpg",
                  width: MediaQuery.of(context).size.width + 50,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                      child: Text(
                        reduceTitle(capitalizeItemTitle(widget.title)),
                        style: const TextStyle(
                            color: background,
                            fontSize: 18.0,
                            fontFamily: 'Proxima Nova Bold'),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                        color: background,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
    ;
  }
}

class FavoriteCarousel extends StatefulWidget {
  const FavoriteCarousel({super.key});

  @override
  State<FavoriteCarousel> createState() => _FavoriteCarouselState();
}

class _FavoriteCarouselState extends State<FavoriteCarousel> {
  List<int> favoriteRecipes = [];
  List<String> favoriteRecipeNames = [];
  void getFavoriteRecipes() async {
    User user = FirebaseAuth.instance.currentUser!;
    List<dynamic> list = [];
    List<int> recipes = [];
    List<String> recipeNames = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('recipes')
        .get()
        .then((value) {
      list = value.docs;
      int count = 1;
      list.forEach((element) {
        if (count <= 10 && element['recipe'] != 0) {
          recipes.add(element['recipe']);
          recipeNames.add(element['title']);
          count++;
        }
      });
      setState(() {
        favoriteRecipes = recipes;
        favoriteRecipeNames = recipeNames;
      });
    });
  }

  String capitalizeItemTitle(String title) {
    String capTitle = "";
    int initIndex = 0, index = 0;
    List<String> words = [], newCapWords = [];

    while (index < title.length) {
      String sub = title.substring(index, index + 1);
      if (sub == " " || index == title.length - 1) {
        if (initIndex == 0) {
          words.add(title.substring(initIndex, index + 1));
        } else {
          words.add(title.substring(initIndex - 1, index + 1));
        }
        initIndex = index + 1;
      }
      index++;
    }
    for (String word in words) {
      Set<String> capWords = {'bbq', 'blt'};
      if (word.substring(0, 1) == " ") {
        word = word.substring(1);
      }
      if (capWords.contains(word)) {
        newCapWords.add(word.toUpperCase());
      } else {
        String firstChar = word.substring(0, 1);
        String endOfWord = word.substring(1);
        newCapWords.add(firstChar.toUpperCase() + endOfWord);
      }
    }
    for (String word in newCapWords) {
      if (word.substring(word.length - 1) == " ") {
        capTitle = "$capTitle$word";
      } else {
        capTitle = "$capTitle$word ";
      }
    }
    return capTitle;
  }

  String reduceTitle(String title) {
    String reducedTitle = title;
    if (title.length >= 27) {
      reducedTitle = '${title.substring(0, 28)}...';
    }
    return reducedTitle;
  }

  @override
  Widget build(BuildContext context) {
    getFavoriteRecipes();
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, position) => FavoriteCard(
              id: favoriteRecipes[position],
              title: favoriteRecipeNames[position],
            ));
  }
}

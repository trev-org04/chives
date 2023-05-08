import 'package:chives/application/api/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

List<dynamic> recipeList = [];

class RecommendedCard extends StatefulWidget {
  final int index, score, id;
  final String title;
  final Future<bool> isPreviouslyFavorited;
  const RecommendedCard(
      {required this.index,
      required this.score,
      required this.id,
      required this.title,
      required this.isPreviouslyFavorited,
      super.key});

  @override
  State<RecommendedCard> createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommendedCard> {
  bool isFavorited = false, initLoad = false;

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
      Set<String> capWords = {'bbq', 'blt', 'Bbq'};
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
    if (title.length >= 20) {
      reducedTitle = '${title.substring(0, 21)}...';
    }
    return reducedTitle;
  }

  int displayDifficulty() {
    print(widget.score);
    int count = 0;
    if (widget.score > 90) {
      count++;
    }
    if (widget.score > 95) {
      count++;
    }
    return count;
  }

  Future<void> setFavorite() async {
    await widget.isPreviouslyFavorited.then((value) {
      isFavorited = value;
      initLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSecondActive = false, isThirdActive = false;
    int count = 2;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!initLoad) {
        setState(() {
          setFavorite();
        });
      }
    });
    if (count == 1) {
      setState(() {
        isSecondActive = true;
      });
    }
    if (count == 2) {
      setState(() {
        isSecondActive = true;
        isThirdActive = true;
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 21.0),
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
                child: Stack(children: [
                  Image.network(
                    "https://spoonacular.com/recipeImages/${recipeList[widget.index]['id']}-312x150.jpg",
                    width: MediaQuery.of(context).size.width + 50,
                    fit: BoxFit.fitWidth,
                  ),
                  GestureDetector(
                    onTap: () async {
                      User user = FirebaseAuth.instance.currentUser!;
                      List<dynamic> list = [];
                      Set<int> recipes = {};
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('recipes')
                          .get()
                          .then((value) {
                        list = value.docs;
                        list.forEach((element) {
                          recipes.add(element['recipe']);
                        });
                      });
                      if (!recipes.contains(widget.id)) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection('recipes')
                            .doc()
                            .set({
                          'recipe': widget.id,
                          'title': widget.title,
                        });
                        setState(() {
                          isFavorited = true;
                        });
                      }
                    },
                    child: Align(
                      alignment: const Alignment(1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 95.0, 15.0, 10.0),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: offWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0))),
                            height: 35,
                            width: 35,
                            child: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: errorColor,
                              size: 25.0,
                            )),
                      ),
                    ),
                  )
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reduceTitle(capitalizeItemTitle(
                                recipeList[widget.index]['title'])),
                            style: const TextStyle(
                                color: background,
                                fontSize: 18.0,
                                fontFamily: 'Proxima Nova Bold'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              '${recipeList[widget.index]['readyInMinutes']} mins',
                              style: const TextStyle(
                                  color: inputColor,
                                  fontSize: 15.0,
                                  fontFamily: 'Proxima Nova SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.15),
                          child: Icon(
                            Icons.star_rounded,
                            size: 22.5,
                            color: isSecondActive ? textWhite : inputColor,
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.15, 0.0),
                              child: Icon(
                                Icons.star_rounded,
                                size: 22.5,
                                color: textWhite,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 0.15, 0.0),
                              child: Icon(
                                Icons.star_rounded,
                                size: 22.5,
                                color: isThirdActive ? textWhite : inputColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class RecommendedCarousel extends StatefulWidget {
  const RecommendedCarousel({super.key});

  @override
  State<RecommendedCarousel> createState() => _RecommendedCarouselState();
}

class _RecommendedCarouselState extends State<RecommendedCarousel> {
  bool initLoadComplete = false;

  void setRecipeList() {
    ApiService api = ApiService.instance;
    Future<RecipeList> recList = api.getRandomRecipes();
    if (!initLoadComplete) {
      recList.then((value) => setState(() {
            recipeList = value.recipeList;
            initLoadComplete = true;
          }));
    }
  }

  int setRecipeDifficulty(int index) {
    String scoreString = "";
    int score = 0;
    scoreString = recipeList[index]['summary'].toString().substring(
        recipeList[index]['summary'].toString().indexOf('score of') + 9,
        recipeList[index]['summary'].toString().indexOf('score of') + 11);
    score = int.parse(scoreString);
    return score;
  }

  Future<bool> hasBeenFavorited(int id) async {
    bool hasBeenFavorited = false;
    User user = FirebaseAuth.instance.currentUser!;
    List<dynamic> list = [];
    Set<int> recipes = {};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('recipes')
        .get()
        .then((value) {
      list = value.docs;
      list.forEach((element) {
        recipes.add(element['recipe']);
      });
      if (recipes.contains(id)) {
        hasBeenFavorited = true;
      }
    });
    return hasBeenFavorited;
  }

  @override
  Widget build(BuildContext context) {
    if (recipeList.length != 10) {
      setRecipeList();
    }
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: recipeList.length,
        itemBuilder: (context, position) => RecommendedCard(
              index: position,
              score: setRecipeDifficulty(position),
              id: recipeList[position]['id'],
              title: recipeList[position]['title'],
              isPreviouslyFavorited:
                  hasBeenFavorited(recipeList[position]['id']),
            ));
  }
}

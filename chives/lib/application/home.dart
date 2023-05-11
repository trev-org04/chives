import 'package:chives/application/api/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';
import 'package:chives/application/recipe_information.dart';

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
                  height: 210,
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
                  height: 238,
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(goToRecipe(widget.id));
      },
      child: Padding(
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
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
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
      ),
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

Route goToRecipe(int id) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RecipeInfo(id: id),
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

  int displayDifficulty() {
    int count = 0;
    if (widget.score > 50) {
      count++;
    }
    if (widget.score > 75) {
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
    int count = displayDifficulty();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!initLoad) {
        setState(() {
          setFavorite();
        });
      }
    });
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(goToRecipe(widget.id));
      },
      child: Padding(
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
                              const EdgeInsets.fromLTRB(0.0, 85.0, 15.0, 10.0),
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
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
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
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 0.15, 0.0),
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
      ),
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
    try {
      score = int.parse(scoreString);
    } catch (e) {
      print(e.toString());
      score = 90;
    }
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

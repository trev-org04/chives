import 'package:chives/application/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

List<dynamic> recipeList = [];

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool hasSearched = false, chosenCategory = false;
  String headingText = "Categories";
  @override
  Widget build(BuildContext context) {
    // Future<Recipe> r = api.fetchRecipe("296687");
    // r.then(
    //   (recipe) {
    //     print(recipe);
    //     int i = 0;
    //     recipe.recipeInfoMap.forEach((key, value) {
    //       print("key" + i.toString() + ": " + key);
    //       if (key.compareTo("title") == 0 || key.compareTo("summary") == 0) {
    //         print(value);
    //       }
    //       i++;
    //     });
    //   },
    // );

    void searchForRecipes(String query) {
      ApiService api = ApiService.instance;
      Future<RecipeList> r = api.getRecipeList(query);
      r.then((value) {
        recipeList = value.recipeList;
        setState(() {
          hasSearched = true;
          chosenCategory = false;
          headingText = "Recipes";
        });
      });
    }

    void searchForCategoryRecipes(String query) {
      ApiService api = ApiService.instance;
      Future<RecipeList> r = api.getCategoryRecipeList(query);
      r.then((value) {
        recipeList = value.recipeList;
        String capQuery =
            "${query.substring(0, 1).toUpperCase()}${query.substring(1)}";
        setState(() {
          chosenCategory = true;
          hasSearched = false;
          headingText = "$capQuery Recipes";
        });
      });
    }

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
                children: const [
                  Text(
                    'EXPLORE',
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
                height: 45,
                decoration: const BoxDecoration(
                    color: offWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: TextField(
                  onSubmitted: (value) {
                    searchForRecipes(value);
                  },
                  style: const TextStyle(
                      color: background, fontFamily: 'HM Sans', fontSize: 15.0),
                  decoration: const InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.only(left: 15.0),
                      hintStyle: TextStyle(
                          fontFamily: 'HM Sans',
                          fontSize: 15.0,
                          color: inputColor),
                      border: InputBorder.none),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 10.0),
            child: Text(
              headingText,
              style: const TextStyle(
                color: offWhite,
                fontFamily: 'Proxima Nova Bold',
                fontSize: 20.0,
              ),
            ),
          ),
          hasSearched
              ? RecipeCardList(recipeList: recipeList)
              : chosenCategory
                  ? RecipeCardList(recipeList: recipeList)
                  : Column(children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchForCategoryRecipes("american");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0, color: inputColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Text("🇺🇸",
                                      style: TextStyle(
                                          color: offWhite,
                                          fontSize: 19,
                                          fontFamily: 'Proxima Nova SemiBold')),
                                ),
                                Text(
                                  'American',
                                  style: TextStyle(
                                      color: offWhite,
                                      fontSize: 19,
                                      fontFamily: 'Proxima Nova SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchForCategoryRecipes("british");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0, color: inputColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Text("🇬🇧",
                                      style: TextStyle(
                                          color: offWhite,
                                          fontSize: 19,
                                          fontFamily: 'Proxima Nova SemiBold')),
                                ),
                                Text(
                                  'British',
                                  style: TextStyle(
                                      color: offWhite,
                                      fontSize: 19,
                                      fontFamily: 'Proxima Nova SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchForCategoryRecipes("indian");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0, color: inputColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Text("🇮🇳",
                                      style: TextStyle(
                                          color: offWhite,
                                          fontSize: 19,
                                          fontFamily: 'Proxima Nova SemiBold')),
                                ),
                                Text(
                                  'Indian',
                                  style: TextStyle(
                                      color: offWhite,
                                      fontSize: 19,
                                      fontFamily: 'Proxima Nova SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchForCategoryRecipes("italian");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0, color: inputColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Text("🇮🇹",
                                      style: TextStyle(
                                          color: offWhite,
                                          fontSize: 19,
                                          fontFamily: 'Proxima Nova SemiBold')),
                                ),
                                Text(
                                  'Italian',
                                  style: TextStyle(
                                      color: offWhite,
                                      fontSize: 19,
                                      fontFamily: 'Proxima Nova SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchForCategoryRecipes("japanese");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0, color: inputColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Text("🇯🇵",
                                      style: TextStyle(
                                          color: offWhite,
                                          fontSize: 19,
                                          fontFamily: 'Proxima Nova SemiBold')),
                                ),
                                Text(
                                  'Japanese',
                                  style: TextStyle(
                                      color: offWhite,
                                      fontSize: 19,
                                      fontFamily: 'Proxima Nova SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchForCategoryRecipes("mexican");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0, color: inputColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Text("🇲🇽",
                                      style: TextStyle(
                                          color: offWhite,
                                          fontSize: 19,
                                          fontFamily: 'Proxima Nova SemiBold')),
                                ),
                                Text(
                                  'Mexican',
                                  style: TextStyle(
                                      color: offWhite,
                                      fontSize: 19,
                                      fontFamily: 'Proxima Nova SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
        ],
      ),
    );
  }
}

class RecipeCardList extends StatefulWidget {
  final List<dynamic> recipeList;
  const RecipeCardList({required this.recipeList, super.key});

  @override
  State<RecipeCardList> createState() => _RecipeCardListState();
}

class _RecipeCardListState extends State<RecipeCardList> {
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
    return Column(
        children: recipeList
            .map((element) => Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: const BoxDecoration(
                          color: offWhite,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: Image.network(
                              "https://spoonacular.com/recipeImages/${element['id']}-312x150.jpg",
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
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 15.0, 0.0, 15.0),
                                  child: Text(
                                    reduceTitle(
                                        capitalizeItemTitle(element['title'])),
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
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 15.0, 15.0, 15.0),
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
                ))
            .toList());
  }
}

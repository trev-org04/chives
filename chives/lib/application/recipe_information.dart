import 'package:chives/application/api/api_service.dart';
import 'package:chives/application/manager.dart';
import 'package:chives/constants.dart';
import 'package:flutter/material.dart';

class RecipeInfo extends StatefulWidget {
  final int id;
  const RecipeInfo({required this.id, super.key});

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  List<String> instructions = [];
  List<dynamic> ingredients = [[], []];
  String recipeTitle = "", recipeSummary = "";

  void getRecipeInfo(int id) {
    ApiService api = ApiService.instance;
    Future<Recipe> r = api.getRecipe("$id");
    r.then(
      (recipe) {
        int i = 0;
        recipe.recipeInfoMap.forEach((key, value) {
          if (recipeSummary.length == 0) {
            if (key.compareTo("summary") == 0) {
              setState(() {
                recipeSummary = removeTags(value);
              });
            }
          }
          if (recipeTitle.length == 0) {
            if (key.compareTo("title") == 0) {
              setState(() {
                recipeTitle = reduceTitle(value).toUpperCase();
              });
            }
          }
          if (key.compareTo("instructions") == 0) {
            if (instructions.isEmpty) {
              setState(() {
                instructions = getInstructions(value);
              });
            }
          }
          if (key.compareTo("extendedIngredients") == 0) {
            setState(() {
              ingredients = getIngredients(value);
            });
          }
          i++;
        });
      },
    );
  }

  List<String> getInstructions(String fullInstructions) {
    List<String> instructions = [];
    Set<String> charsToRemove = {'<', '>', '/', 'o', 'l', 'i', ' '};
    String str = fullInstructions;
    while (str.indexOf('.') > 0) {
      int stop = str.indexOf('.') + 1;
      String instruction = str.substring(0, stop);
      int count = 0;
      String sub = instruction.substring(count, count + 1);
      while (charsToRemove.contains(sub)) {
        instruction = instruction.substring(count + 1);
        sub = instruction.substring(count, count + 1);
      }
      if (instruction.substring(0, 1).compareTo('\n') == 0) {
        instruction = instruction.substring(1);
      }
      instructions.add(instruction);
      str = str.substring(stop);
    }
    return instructions;
  }

  List<dynamic> getIngredients(List<dynamic> fullIngredients) {
    List<String> ingredients = [];
    List<String> imageNames = [];
    fullIngredients.forEach((element) {
      String ingredientName = element['name'];
      String ingredientAmount = element['measures']['us']['amount'].toString();
      String ingredientUnits = element['measures']['us']['unitShort'];
      String ingredientImage = element['image'];
      ingredients.add('$ingredientAmount $ingredientUnits of $ingredientName');
      imageNames.add(ingredientImage);
    });
    return [ingredients, imageNames];
  }

  String removeTags(String content) {
    String tagFreeContent = content;
    while (tagFreeContent.indexOf('<') != -1) {
      int index = tagFreeContent.indexOf('<');

      if (tagFreeContent.substring(index + 1, index + 2).compareTo('b') == 0) {
        if (index == 0) {
          tagFreeContent = tagFreeContent.substring(index + 3);
        } else {
          String preTagContent = tagFreeContent.substring(0, index);
          String postTagContent = tagFreeContent.substring(index + 3);
          tagFreeContent = preTagContent + postTagContent;
        }
      } else if (tagFreeContent
              .substring(index + 1, index + 2)
              .compareTo('/') ==
          0) {
        if (index == 0) {
          tagFreeContent = tagFreeContent.substring(index + 4);
        } else {
          String preTagContent = tagFreeContent.substring(0, index);
          String postTagContent = tagFreeContent.substring(index + 4);
          tagFreeContent = preTagContent + postTagContent;
        }
      } else if (tagFreeContent
              .substring(index + 1, index + 2)
              .compareTo('a') ==
          0) {
        int endIndex = tagFreeContent.indexOf('>');
        String preTagContent = tagFreeContent.substring(0, index - 1);
        String postTagContent = tagFreeContent.substring(endIndex + 1);
        tagFreeContent = '$preTagContent $postTagContent ';
      }
    }

    return tagFreeContent;
  }

  @override
  Widget build(BuildContext context) {
    if (recipeTitle.length == 0) {
      getRecipeInfo(widget.id);
    }
    print(instructions);

    return Material(
      child: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    flexibleSpace: Image.network(
                      "https://spoonacular.com/recipeImages/${widget.id}-312x231.jpg",
                      fit: BoxFit.fill,
                    ),
                    toolbarHeight: 40,
                    actions: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            MediaQuery.of(context).size.width - 50, 0.0),
                        child: Container(
                          width: 40,
                          decoration: const BoxDecoration(
                              color: offWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(_createGoBackRoute());
                            },
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: textWhite,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                    expandedHeight: 300,
                    forceElevated: innerBoxIsScrolled,
                    bottom: const CustomTabBar(),
                  ),
                ],
            body: TabBarView(
              children: [
                Container(
                    color: darkGreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                          child: Text(
                            recipeTitle,
                            style: const TextStyle(
                                color: textWhite,
                                fontSize: 23.0,
                                fontFamily: 'Proxima Nova',
                                letterSpacing: 1.0),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, position) => Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 0.0, 25.0, 0.0),
                              child: Text(
                                recipeSummary,
                                style: const TextStyle(
                                  color: textWhite,
                                  fontSize: 16.0,
                                  fontFamily: 'HM Sans',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                    color: mediumGreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 15.0),
                          child: Text(
                            'INGREDIENTS',
                            style: TextStyle(
                                color: textWhite,
                                fontSize: 23.0,
                                fontFamily: 'Proxima Nova',
                                letterSpacing: 1.0),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 50,
                          child: GridView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 0.0, 0.0, 0.0),
                              itemCount: ingredients[0].length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio:
                                          MediaQuery.of(context).size.height /
                                              825,
                                      crossAxisCount: 2),
                              itemBuilder: (context, position) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 12.5, 25.0, 12.5),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: offWhite,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 100,
                                                  decoration: const BoxDecoration(
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                ),
                                                Image.network(
                                                  "https://spoonacular.com/cdn/ingredients_100x100/${ingredients[1][position]}",
                                                ),
                                              ]),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              ingredients[0][position],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: background,
                                                fontFamily: 'HM Sans',
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  color: lightGreen,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                            child: Text(
                              'INSTRUCTIONS',
                              style: TextStyle(
                                  color: textWhite,
                                  fontSize: 23.0,
                                  fontFamily: 'Proxima Nova',
                                  letterSpacing: 1.0),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 75,
                            child: ListView.builder(
                              itemCount: instructions.length,
                              itemBuilder: (context, position) => Padding(
                                padding: position == 0
                                    ? const EdgeInsets.fromLTRB(
                                        25.0, 0.0, 25.0, 0.0)
                                    : const EdgeInsets.fromLTRB(
                                        25.0, 10.0, 25.0, 0.0),
                                child: Text(
                                  '${position + 1}. ${instructions[position]}',
                                  style: const TextStyle(
                                    color: textWhite,
                                    fontSize: 16.0,
                                    fontFamily: 'HM Sans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(color: inputColor, width: 2.0)),
        color: index == 0
            ? darkGreen
            : index == 1
                ? mediumGreen
                : lightGreen,
      ),
      child: TabBar(
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
        indicator: BoxDecoration(
          color: index == 0
              ? mediumGreen
              : index == 1
                  ? lightGreen
                  : darkGreen,
        ),
        labelColor: textWhite,
        unselectedLabelColor: inputColor,
        tabs: const [
          Tab(
            child: Text(
              'Summary',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'HM Sans',
              ),
            ),
          ),
          Tab(
            child: Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'HM Sans',
              ),
            ),
          ),
          Tab(
            child: Text(
              'Instructions',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'HM Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Route _createGoBackRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Manager(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
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

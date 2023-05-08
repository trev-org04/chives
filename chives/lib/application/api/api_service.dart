import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Recipe {
  final Map<String, dynamic> recipeInfoMap;

  Recipe({required this.recipeInfoMap});

  factory Recipe.mapFromMap(Map<String, dynamic> map) {
    return Recipe(recipeInfoMap: map);
  }
}

class RecipeList {
  final List<dynamic> recipeList;

  RecipeList({required this.recipeList});

  factory RecipeList.mapFromList(List<dynamic> list) {
    return RecipeList(recipeList: list);
  }

  factory RecipeList.mapFromMapCategory(Map<String, dynamic> map) {
    List<dynamic> list = map['results'];
    return RecipeList(recipeList: list);
  }

  factory RecipeList.mapFromMapRandom(Map<String, dynamic> map) {
    List<dynamic> list = map['recipes'];
    return RecipeList(recipeList: list);
  }
}

class ApiService {
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();
  final String baseURL = "api.spoonacular.com";
  static const String apiKey = "";

  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': apiKey,
    };
    Uri uri = Uri.https(
      baseURL,
      '/recipes/$id/information',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = await json.decode(response.body);
      Recipe recipe = Recipe.mapFromMap(data);
      print("success");
      return recipe;
    } catch (err) {
      print("failure");
      throw err.toString();
    }
  }

  Future<RecipeList> getRecipeList(String query) async {
    Map<String, String> parameters = {
      'number': '8',
      'query': query,
      'apiKey': apiKey,
    };
    Uri uri = Uri.https(
      baseURL,
      '/recipes/autocomplete',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      List<dynamic> data = await json.decode(response.body);
      RecipeList recipeList = RecipeList.mapFromList(data);
      print("success");
      return recipeList;
    } catch (err) {
      print("failure");
      throw err.toString();
    }
  }

  Future<RecipeList> getCategoryRecipeList(String query) async {
    Map<String, String> parameters = {
      'number': '8',
      'cuisine': query,
      'apiKey': apiKey,
    };
    Uri uri = Uri.https(
      baseURL,
      '/recipes/complexSearch',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = await json.decode(response.body);
      RecipeList recipeList = RecipeList.mapFromMapCategory(data);
      print("success");
      return recipeList;
    } catch (err) {
      print("failure");
      throw err.toString();
    }
  }

  Future<RecipeList> getRandomRecipes() async {
    Map<String, String> parameters = {
      'number': '10',
      'apiKey': apiKey,
    };
    Uri uri = Uri.https(
      baseURL,
      '/recipes/random',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      print('uri: ' + uri.toString());
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = await json.decode(response.body);
      RecipeList recipeList = RecipeList.mapFromMapRandom(data);
      print("success");
      return recipeList;
    } catch (err) {
      print("failure");
      throw err.toString();
    }
  }
}

import 'dart:async';
import 'package:foodre/Model/IngredientsIdsList.dart';
import 'package:foodre/Model/PopularFoodModel.dart';
import 'package:foodre/Model/RecommendedModel.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const API_KEY = "5304c50189c140ed95c93795348f95d6";
const String apiUrl =
    "https://api.spoonacular.com/recipes/random?number=10&tags=vegetarian,dessert&apiKey=$API_KEY";
const String idUrl =
    "https://api.spoonacular.com/recipes/findByIngredients?ingredients=chicken,+pasta,+Bread,+Seafood,+Baking,+Cheese&number=100&apiKey=$API_KEY";

//API 2: 5304c50189c140ed95c93795348f95d6
//API 3: dc6ef4b7e3f24dab87ae736708b7daff

//TODO: Fix function number line 58
//TODO: Request Api key only two time or reduce it.

List<PopularFoodModel> theFoodListInfo = [];
List<PopularFoodModel> theFavFoodListInfo = [];
List<PopularFoodModel> idsss = [];

String filteredId(String id) {
  String ii = id.replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
  return ii;
}

Future<List<RecommendModel>> getRecommendedRecipesInfo() async {
  var url = Uri.parse(apiUrl);
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    Map data = jsonDecode(response.body); //returns map
    List<dynamic> recipesInfo = data['recipes'];
    return recipesInfo.map((e) => RecommendModel.fromJson(e)).toList();
  } else {
    throw Exception("Something went wrong  ${response.body}");
  }
}

//--------------------------------------------------------------------------------------//

Future<List<PopularFoodModel>> getRecipesId() async {
  var url = Uri.parse(idUrl);
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body); //return list
    return getRecipesInformation(
        data.map((e) => IngredientsIdsList.fromJson(e)).toList());
  } else {
    throw Exception("OH no");
  }
}

Future<List<PopularFoodModel>> getRecipesInformation(
    List<IngredientsIdsList> ids) async {
  var requestedIds = [];
  ids.forEach((i) => requestedIds.add(i.id));
  String retrievedIds = filteredId(requestedIds.toString());
  String recipesInformation =
      "https://api.spoonacular.com/recipes/informationBulk?ids=$retrievedIds&apiKey=$API_KEY";

  var url = Uri.parse(recipesInformation);
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    Iterable jsonData = json.decode(response.body);
    idsss = jsonData.map((e) => PopularFoodModel.fromJson(e)).toList();

    return idsss;
  } else {
    throw Exception("OH NONONO");
  }
}
////---------------------------------------------------------------------------------//
Future<List<PopularFoodModel>> getFavFood(List<String> ids) async {
  var requestedIds = [];
  ids.forEach((i) {
    requestedIds.add(i);
  });
  String retrievedIds = filteredId(requestedIds.toString());

  String informationUrl =
      "https://api.spoonacular.com/recipes/informationBulk?ids=$retrievedIds&apiKey=$API_KEY";

  var file = await DefaultCacheManager().getSingleFile(informationUrl);

  if (file != null && await file.exists()) {
    var res = await file.readAsString();
    Iterable l = (json.decode(res));
    print("hahahahaha ${l}");

    theFavFoodListInfo =
        l.map((model) => PopularFoodModel.fromJson(model)).toList();
  }
  return theFavFoodListInfo;
}

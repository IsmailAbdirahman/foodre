import 'dart:async';
import 'package:foodre/Model/FoodInfo.dart';
import 'package:foodre/Model/IngredientsIdsList.dart';
import 'package:foodre/Model/RecommendedModel.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';



const API_KEY = "8b8e9b00804e4d6ca07b7ee3198e580a";


List<RecommendModel> theRecommendedList =[];
List<IngredientsIdsList> idsList = [];
List<PopularFoodModel> theFoodListInfo = [];


Future<List<RecommendModel>> getRecommendedRecipesInfo() async {
  String informationUrl =
      "https://api.spoonacular.com/recipes/random?number=10&tags=vegetarian,dessert&apiKey=$API_KEY";

  var file = await DefaultCacheManager().getSingleFile(informationUrl);

  if (file != null && await file.exists()) {
    var res = await file.readAsString();
    var l = (json.decode(res));

    l['recipes'].forEach((element) {
      theRecommendedList.add(new RecommendModel.fromJson(element));
    });
  }
  return theRecommendedList;
}

//--------------------------------------------------------------------------------------//


Future<List<PopularFoodModel>> getRecipesId() async {
  String idUrl =
      "https://api.spoonacular.com/recipes/findByIngredients?ingredients=chicken,+pasta,+Bread,+Seafood,+Baking,+Cheese&number=100&apiKey=$API_KEY";

  var file = await DefaultCacheManager().getSingleFile(idUrl);

  if (file != null && await file.exists()) {
    var res = await file.readAsString();
    var jsonData = json.decode(res);

    jsonData.forEach((element) {
      if (element['id'] != null) {
        IngredientsIdsList ingredientsIdsList =
            IngredientsIdsList(id: element['id']);
        idsList.add(ingredientsIdsList);
      }
    });
  }
  return getRecipesInformation(idsList);
}



Future<List<PopularFoodModel>> getRecipesInformation(List<IngredientsIdsList> ids) async {
  var requestedIds = [];
  ids.forEach((i) {
    requestedIds.add(i.id);
  });
  String retrievedIds = requestedIds
      .toString()
      .replaceAll("[", "")
      .replaceAll("]", "")
      .replaceAll(" ", "");
  String informationUrl =
      "https://api.spoonacular.com/recipes/informationBulk?ids=$retrievedIds&apiKey=$API_KEY";

  var file = await DefaultCacheManager().getSingleFile(informationUrl);

  if (file != null && await file.exists()) {
    var res = await file.readAsString();
    Iterable l = (json.decode(res));

    List<PopularFoodModel> theFoodListInfo =
        l.map((model) => PopularFoodModel.fromJson(model)).toList();
    return theFoodListInfo;

  }

}

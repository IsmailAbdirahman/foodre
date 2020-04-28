import 'dart:async';

import 'package:foodre/Model/FoodInfo.dart';
import 'package:foodre/Model/IngredientsIdsList.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

const API_KEY = "c262fcf3b51846488e38c96ace130e77";

//List<FoodInformation> theFoodList = [];
//
//Future<List<FoodInformation>> getData() async {
//  String url =
//      "https://api.spoonacular.com/recipes/716429/information?&apiKey=4129ea26833549458067047625810c33";
//  var response = await http.get(url);
//
//  print("THTHTH${FoodInformation.fromJson(json.decode(response.body))}");
//  theFoodList.add(FoodInformation.fromJson(json.decode(response.body)));
//  return theFoodList;
//}

//--------------------------------------------------------------------------------------//

List<IngredientsIdsList> idsList = [];
List<FoodInformation> theFoodListInfo = [];

Future<List<FoodInformation>> getRecipesId() async {
  String idUrl =
      "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=60&apiKey=$API_KEY";

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
    return getRecipesInformation(idsList);
}



//  var response = await http.get(idUrl);
//  var jsonData = json.decode(response.body);
//
//  jsonData.forEach((element) {
//    if (element['id'] != null) {
//      IngredientsIdsList ingredientsIdsList =
//          IngredientsIdsList(id: element['id']);
//      idsList.add(ingredientsIdsList);
//    }
//  });
//    return getRecipesInformation(idsList);

}


 Future<List<FoodInformation>> getRecipesInformation(List<IngredientsIdsList> ids) async {
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
     theFoodListInfo = (json.decode(res) as List).map((i) =>
         FoodInformation.fromJson(i)).toList();

     return theFoodListInfo;
   }
 }
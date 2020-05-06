//import 'package:foodre/Model/ExtendedIngredients.dart';
//
//class FoodInformation {
//  final String foodTitle;
//  final String foodImageUrl;
//  final int mints;
//  final String instructions;
//  final int servings;
//  final List<ExtendedIngredients> extendedIngredients;
//
//
//  FoodInformation(
//      {this.foodTitle, this.foodImageUrl, this.mints,this.instructions,this.servings, this.extendedIngredients});
//
//
//  factory FoodInformation.fromJson(Map<String, dynamic> parsedJson) {
//
//    var list = parsedJson['extendedIngredients'] as List;
//
//    List<ExtendedIngredients> imagesList = list.map((i) => ExtendedIngredients.fromJson(i)).toList();
//
//
//    return FoodInformation(
//        foodTitle: parsedJson['title'],
//        foodImageUrl: parsedJson['image'],
//        mints: parsedJson['readyInMinutes'],
//        instructions: parsedJson['instructions'],
//        servings: parsedJson['servings'],
//        extendedIngredients: imagesList
//    );
//  }
//}
//

import 'package:flutter/foundation.dart';
import 'package:foodre/Model/ExtendedIngredients.dart';

class FoodInformation {
  String foodTitle;
  String foodImageUrl;
  int mints;
  String steps;
  int servings;
  List<String> dishType = [];
  List<ExtendedIngredients> extendedIngredients;

  FoodInformation(
      {this.foodTitle,
      this.foodImageUrl,
      this.mints,
      this.steps,
      this.servings,
      this.extendedIngredients,
      this.dishType});

  FoodInformation.fromJson(Map<String, dynamic> parsedJson) {
    final inistructions = parsedJson['instructions'];
    var list = parsedJson['extendedIngredients'] as List;
    List<ExtendedIngredients> imagesList =
        list.map((i) => ExtendedIngredients.fromJson(i)).toList();
    var dishTypeFromJson = parsedJson['dishTypes'];
    List<String> dishTypeList = dishTypeFromJson.cast<String>();

    foodTitle = parsedJson['title'];
    foodImageUrl = parsedJson['image'];
    mints = parsedJson['readyInMinutes'];
    servings = parsedJson['servings'];
    extendedIngredients = imagesList;
    dishType = dishTypeList;
    steps = inistructions;
  }

//  factory FoodInformation.fromJsonbr(Map<String, dynamic> parsedJson) {
//
//    var list = parsedJson['extendedIngredients'] as List;
//    List<ExtendedIngredients> imagesList = list.map((i) => ExtendedIngredients.fromJson(i)).toList();
//    var dishTypeFromJson = parsedJson['dishTypes'];
//    List<String> dishTypeList = dishTypeFromJson.cast<String>();
//
//    return FoodInformation(
//      foodTitle : parsedJson['title'],
//      foodImageUrl : parsedJson['image'],
//      mints : parsedJson['readyInMinutes'],
//      instructions : parsedJson['instructions'],
//      servings : parsedJson['servings'],
//      extendedIngredients : imagesList,
//      dishType : dishTypeList,
//    );
//
//  }
//
////
////  FoodInformation.fromJsonlnch(Map<String, dynamic> parsedJson) {
////    var list = parsedJson['extendedIngredients'] as List;
////    List<ExtendedIngredients> imagesList = list.map((i) => ExtendedIngredients.fromJson(i)).toList();
////    var streetsFromJson = parsedJson['dishTypes'];
////    List<String> streetsList = streetsFromJson.cast<String>();
////
////
////    if (parsedJson['extendedIngredients'] != null && streetsList.contains("lunch")) {
////      foodTitle = parsedJson['title'];
////      foodImageUrl = parsedJson['image'];
////      mints = parsedJson['readyInMinutes'];
////      instructions = parsedJson['instructions'];
////      servings = parsedJson['servings'];
////      extendedIngredients = imagesList;
////      dishType = streetsList;
////    }
////  }
////
////
////  FoodInformation.fromJsondnr(Map<String, dynamic> parsedJson) {
////    var list = parsedJson['extendedIngredients'] as List;
////    List<ExtendedIngredients> imagesList = list.map((i) => ExtendedIngredients.fromJson(i)).toList();
////    var streetsFromJson = parsedJson['dishTypes'];
////    List<String> streetsList = streetsFromJson.cast<String>();
////
////
////    if (parsedJson['extendedIngredients'] != null && streetsList.contains('main dish') ) {
////      foodTitle = parsedJson['title'];
////      foodImageUrl = parsedJson['image'];
////      mints = parsedJson['readyInMinutes'];
////      instructions = parsedJson['instructions'];
////      servings = parsedJson['servings'];
////      extendedIngredients = imagesList;
////      dishType = streetsList;
////    }
////  }
}

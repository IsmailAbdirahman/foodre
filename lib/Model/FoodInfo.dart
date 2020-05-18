import 'package:foodre/Model/ExtendedIngredients.dart';

class PopularFoodModel {
  int id;
  String foodTitle;
  String foodImageUrl;
  int mints;
  String steps;
  int servings;

  List<String> dishType = [];
  List<ExtendedIngredients> extendedIngredients;

  PopularFoodModel(
      {this.foodTitle,
        this.id,
      this.foodImageUrl,
      this.mints,
      this.steps,
      this.servings,
      this.extendedIngredients,
      this.dishType});

  PopularFoodModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['extendedIngredients'] as List;
    List<ExtendedIngredients> imagesList =
        list.map((i) => ExtendedIngredients.fromJson(i)).toList();
    var dishTypeFromJson = parsedJson['dishTypes'];
    List<String> dishTypeList = dishTypeFromJson.cast<String>();
    id = parsedJson['id'];
    foodTitle = parsedJson['title'];
    foodImageUrl = parsedJson['image'];
    mints = parsedJson['readyInMinutes'];
    servings = parsedJson['servings'];
    extendedIngredients = imagesList;
    dishType = dishTypeList;
    steps = parsedJson['instructions'];
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

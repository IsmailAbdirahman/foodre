
import 'ExtendedIngredients.dart';



class  RecommendModel{
  String foodTitle;
  String foodImageUrl;
  int mints;
  String steps;
  int servings;
  List<String> dishType = [];
  List<ExtendedIngredients> extendedIngredients;

  RecommendModel(
      {this.foodTitle,
        this.foodImageUrl,
        this.mints,
        this.steps,
        this.servings,
        this.extendedIngredients,
        this.dishType});

  RecommendModel.fromJson(Map<String, dynamic> parsedJson) {
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
}
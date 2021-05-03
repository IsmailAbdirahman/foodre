import 'package:foodre/Model/ExtendedIngredients.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PopularFoodModel.g.dart';

@JsonSerializable()
class PopularFoodModel {
  int? id;
  String? title;
  String? image;
  int? readyInMinutes;
  String? instructions;
  int? servings;

  List<String>? dishTypes = [];
  List<ExtendedIngredients>? extendedIngredients;

  PopularFoodModel(
      {this.title,
      this.id,
      this.image,
      this.readyInMinutes,
      this.instructions,
      this.servings,
      this.extendedIngredients,
      this.dishTypes});

  factory PopularFoodModel.fromJson(Map<String, dynamic> json) =>
      _$PopularFoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularFoodModelToJson(this);

// PopularFoodModel.fromJson(Map<String, dynamic> parsedJson) {
//   var list = parsedJson['extendedIngredients'] as List;
//   List<ExtendedIngredients> imagesList =
//       list.map((i) => ExtendedIngredients.fromJson(i)).toList();
//   var dishTypeFromJson = parsedJson['dishTypes'];
//   List<String> dishTypeList = dishTypeFromJson.cast<String>();
//   id = parsedJson['id'];
//   foodTitle = parsedJson['title'];
//   foodImageUrl = parsedJson['image'];
//   mints = parsedJson['readyInMinutes'];
//   servings = parsedJson['servings'];
//   extendedIngredients = imagesList;
//   dishType = dishTypeList;
//   steps = parsedJson['instructions'];
// }

}

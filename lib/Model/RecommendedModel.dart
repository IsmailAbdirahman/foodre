import 'package:json_annotation/json_annotation.dart';

import 'ExtendedIngredients.dart';

part 'RecommendedModel.g.dart';

@JsonSerializable()
class RecommendModel {
  String? title;
  String? image;
  int? readyInMinutes;
  String? instructions;
  int? servings;
  List<String>? dishTypes = [];
  List<ExtendedIngredients>? extendedIngredients;

  RecommendModel(
      {this.title,
      this.image,
      this.readyInMinutes,
      this.instructions,
      this.servings,
      this.extendedIngredients,
      this.dishTypes});

  factory RecommendModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendModelToJson(this);
}

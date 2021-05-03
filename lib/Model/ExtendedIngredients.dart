import 'package:json_annotation/json_annotation.dart';

part 'ExtendedIngredients.g.dart';

@JsonSerializable()
class ExtendedIngredients {
  final String? image;
  final String? name;
  final double? amount;
  final String? unit;

  ExtendedIngredients({this.image, this.name, this.amount, this.unit});


  factory ExtendedIngredients.fromJson(Map<String, dynamic> json) =>
      _$ExtendedIngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedIngredientsToJson(this);

}

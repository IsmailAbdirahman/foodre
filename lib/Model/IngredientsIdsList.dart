
import 'package:json_annotation/json_annotation.dart';


part 'IngredientsIdsList.g.dart';
@JsonSerializable()
class IngredientsIdsList {
  int? id;

  IngredientsIdsList({this.id});

  factory IngredientsIdsList.fromJson(Map<String, dynamic> json) =>
      _$IngredientsIdsListFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsIdsListToJson(this);
}

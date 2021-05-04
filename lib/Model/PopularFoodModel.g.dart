// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PopularFoodModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularFoodModel _$PopularFoodModelFromJson(Map<String, dynamic> json) {
  return PopularFoodModel(
    title: json['title'] as String?,
    id: json['id'] as int?,
    image: json['image'] as String?,
    readyInMinutes: json['readyInMinutes'] as int?,
    instructions: json['instructions'] as String?,
    servings: json['servings'] as int?,
    extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
        ?.map((e) => ExtendedIngredients.fromJson(e as Map<String, dynamic>))
        .toList(),
    dishTypes:
        (json['dishTypes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PopularFoodModelToJson(PopularFoodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'readyInMinutes': instance.readyInMinutes,
      'instructions': instance.instructions,
      'servings': instance.servings,
      'dishTypes': instance.dishTypes,
      'extendedIngredients': instance.extendedIngredients,
    };

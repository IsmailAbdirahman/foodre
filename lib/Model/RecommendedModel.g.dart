// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecommendedModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendModel _$RecommendModelFromJson(Map<String, dynamic> json) {
  return RecommendModel(
    title: json['title'] as String?,
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

Map<String, dynamic> _$RecommendModelToJson(RecommendModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'readyInMinutes': instance.readyInMinutes,
      'instructions': instance.instructions,
      'servings': instance.servings,
      'dishTypes': instance.dishTypes,
      'extendedIngredients': instance.extendedIngredients,
    };

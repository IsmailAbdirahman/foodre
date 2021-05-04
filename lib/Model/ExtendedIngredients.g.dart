// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExtendedIngredients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedIngredients _$ExtendedIngredientsFromJson(Map<String, dynamic> json) {
  return ExtendedIngredients(
    image: json['image'] as String?,
    name: json['name'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
    unit: json['unit'] as String?,
  );
}

Map<String, dynamic> _$ExtendedIngredientsToJson(
        ExtendedIngredients instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
    };

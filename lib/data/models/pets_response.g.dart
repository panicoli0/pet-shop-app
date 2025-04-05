// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetsResponse _$PetsResponseFromJson(Map<String, dynamic> json) => PetsResponse(
      pets: (json['pets'] as List<dynamic>)
          .map((e) => PetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetsResponseToJson(PetsResponse instance) =>
    <String, dynamic>{
      'pets': instance.pets,
    };

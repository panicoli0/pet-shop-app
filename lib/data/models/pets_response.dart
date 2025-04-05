import 'package:json_annotation/json_annotation.dart';
import 'package:pets_shop/data/models/pet_model.dart';

part 'pets_response.g.dart';

@JsonSerializable()
class PetsResponse {
  final List<PetModel> pets;

  PetsResponse({required this.pets});

  factory PetsResponse.fromJson(Map<String, dynamic> json) =>
      _$PetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PetsResponseToJson(this);
}

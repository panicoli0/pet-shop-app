import 'dart:async';
import 'package:pets_shop/data/mocks/pets_list_mock.dart';
import 'package:pets_shop/data/models/pet_model.dart';

abstract class IPetRemoteDataSource {
  Future<List<PetModel>> getPets();
  Future<List<PetModel>> searchPets(String query);
}

class PetRemoteDataSource implements IPetRemoteDataSource {
  @override
  Future<List<PetModel>> getPets() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      return PetsListMock.petsListJson
          .map((json) => PetModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch pets: $e');
    }
  }

  @override
  Future<List<PetModel>> searchPets(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final allPets = await getPets();
      return allPets
          .where((pet) =>
              pet.name.toLowerCase().contains(query.toLowerCase()) ||
              pet.breed.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search pets: $e');
    }
  }
}

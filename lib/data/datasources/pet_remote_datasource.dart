import 'dart:async';
import 'package:pets_shop/data/models/pet_model.dart';
import 'package:pets_shop/data/services/pets_service.dart';

abstract class IPetRemoteDataSource {
  Future<List<PetModel>> getPets();
  Future<List<PetModel>> searchPets(String query);
}

class PetRemoteDataSource implements IPetRemoteDataSource {
  final PetService _service;

  PetRemoteDataSource(this._service);

  @override
  Future<List<PetModel>> getPets() async {
    try {
      return await _service.getPets();
    } catch (e) {
      throw Exception('Failed to fetch pets: $e');
    }
  }

  @override
  Future<List<PetModel>> searchPets(String query) async {
    try {
      return await _service.searchPets(query);
    } catch (e) {
      throw Exception('Failed to search pets: $e');
    }
  }
}

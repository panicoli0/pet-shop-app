import 'package:pets_shop/data/datasources/pet_local_datasource.dart';
import 'package:pets_shop/data/models/pet_model.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class PetRepositoryImpl implements IPetRepository {
  final IPetLocalDataSource localDataSource;

  PetRepositoryImpl({required this.localDataSource});

  final List<PetModel> _pets = [
    PetModel(
      id: 1,
      name: 'Buddy',
      breed: 'Golden Retriever',
      age: 3,
      imageUrl: 'resources/images/buddy2.jpeg',
    ),
    PetModel(
      id: 2,
      name: 'Whiskers',
      breed: 'Siamese',
      age: 2,
      imageUrl: 'resources/images/cat1.jpeg',
    ),
  ];

  @override
  Future<List<PetEntity>> getPets() async {
    try {
      final localPets = await localDataSource.getPets();
      if (localPets.isNotEmpty) {
        return localPets;
      }

      // If we were getting data from an API, we would use PetModel.fromJson here
      return _pets;
    } catch (e) {
      throw Exception('Failed to get pets: $e');
    }
  }

  @override
  Future<void> addPet(PetModel pet) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _pets.add(pet);
      await localDataSource.cachePets(_pets);
    } catch (e) {
      throw Exception('Failed to add pet: $e');
    }
  }

  @override
  Future<List<PetEntity>> filterByBreed(String breed) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return _pets
          .where((pet) => pet.breed.toLowerCase() == breed.toLowerCase())
          .toList();
    } catch (e) {
      throw Exception('Failed to filter pets by breed: $e');
    }
  }

  @override
  Future<List<PetEntity>> searchPets(String query) async {
    try {
      return _pets
          .where((pet) =>
              pet.name.toLowerCase().contains(query.toLowerCase()) ||
              pet.breed.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search pets: $e');
    }
  }
}

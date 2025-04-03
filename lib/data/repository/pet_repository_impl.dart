import 'package:pets_shop/data/datasources/pet_local_datasource.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class PetRepositoryImpl implements IPetRepository {
  final IPetLocalDataSource localDataSource;

  PetRepositoryImpl({required this.localDataSource});

  final List<PetEntity> _pets = [
    PetEntity(
      id: 1,
      name: 'Buddy',
      breed: 'Golden Retriever',
      age: 3,
      imageUrl: 'resources/images/buddy2.jpeg',
    ),
    PetEntity(
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
      // First, try to get from local cache
      final localPets = await localDataSource.getPets();
      if (localPets.isNotEmpty) {
        return localPets;
      }

      // If cache is empty, get from "network" and cache it
      await Future.delayed(const Duration(milliseconds: 300));
      await localDataSource.cachePets(_pets);
      return _pets;
    } catch (e) {
      throw Exception('Failed to get pets: $e');
    }
  }

  @override
  Future<void> addPet(PetEntity pet) async {
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

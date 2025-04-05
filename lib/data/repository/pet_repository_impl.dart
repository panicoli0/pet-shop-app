import 'package:pets_shop/data/datasources/pet_local_datasource.dart';
import 'package:pets_shop/data/datasources/pet_remote_datasource.dart';
import 'package:pets_shop/data/models/pet_model.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class PetRepositoryImpl implements IPetRepository {
  final IPetLocalDataSource localDataSource;
  final IPetRemoteDataSource remoteDataSource;

  PetRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<PetEntity>> getPets() async {
    try {
      // First try to get from local cache
      final localPets = await localDataSource.getPets();
      if (localPets.isNotEmpty) {
        return localPets;
      }

      // If cache is empty, fetch from remote and cache it
      final remotePets = await remoteDataSource.getPets();
      await localDataSource.cachePets(remotePets);
      return remotePets;
    } catch (e) {
      throw Exception('Failed to get pets: $e');
    }
  }

  @override
  Future<List<PetEntity>> searchPets(String query) async {
    try {
      return await remoteDataSource.searchPets(query);
    } catch (e) {
      throw Exception('Failed to search pets: $e');
    }
  }

  @override
  Future<void> addPet(PetModel pet) async {
    try {
      // Here you would typically send the pet to the server first
      await Future.delayed(const Duration(milliseconds: 300));
      await localDataSource.cachePets([pet]);
    } catch (e) {
      throw Exception('Failed to add pet: $e');
    }
  }

  @override
  Future<List<PetEntity>> filterByBreed(String breed) async {
    try {
      final pets = await getPets();
      return pets
          .where((pet) => pet.breed.toLowerCase() == breed.toLowerCase())
          .toList();
    } catch (e) {
      throw Exception('Failed to filter pets by breed: $e');
    }
  }
}

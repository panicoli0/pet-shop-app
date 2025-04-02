import 'package:pets_shop/data/repository/pet_repository.dart';
import 'package:pets_shop/domain/models/pet.dart';

class PetRepositoryImpl implements IPetRepository {
  final List<Pet> _pets = [
    Pet(
      name: 'Buddy',
      breed: 'Golden Retriever',
      age: 3,
      imageUrl: 'resources/images/buddy2.jpeg',
    ),
    Pet(
      name: 'Whiskers',
      breed: 'Siamese',
      age: 2,
      imageUrl: 'resources/images/cat1.jpeg',
    ),
  ];

  @override
  Future<List<Pet>> getPets() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _pets;
  }

  @override
  Future<void> addPet(Pet pet) async {
    await Future.delayed(const Duration(seconds: 1));
    _pets.add(pet);
  }

  @override
  Future<List<Pet>> searchPets(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _pets
        .where((pet) =>
            pet.name.toLowerCase().contains(query.toLowerCase()) ||
            pet.breed.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Pet>> filterByBreed(String breed) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _pets
        .where((pet) => pet.breed.toLowerCase() == breed.toLowerCase())
        .toList();
  }
}

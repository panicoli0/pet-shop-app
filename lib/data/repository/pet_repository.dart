import 'package:pets_shop/domain/models/pet.dart';

abstract class IPetRepository {
  Future<List<Pet>> getPets();
  Future<void> addPet(Pet pet);
  Future<List<Pet>> searchPets(String query);
  Future<List<Pet>> filterByBreed(String breed);
}

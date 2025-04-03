import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

abstract class IPetRepository {
  Future<List<PetEntity>> getPets();
  Future<void> addPet(PetEntity pet);
  Future<List<PetEntity>> searchPets(String query);
  Future<List<PetEntity>> filterByBreed(String breed);
}

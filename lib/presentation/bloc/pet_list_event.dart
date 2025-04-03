import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

abstract class PetListEvent {}

class LoadPets extends PetListEvent {}

class SearchPets extends PetListEvent {
  final String query;
  SearchPets(this.query);
}

class FilterPetsByBreed extends PetListEvent {
  final String breed;
  FilterPetsByBreed(this.breed);
}

class AddPet extends PetListEvent {
  final PetEntity pet;
  AddPet(this.pet);
}

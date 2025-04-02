import 'package:pets_shop/domain/models/pet.dart';

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
  final Pet pet;
  AddPet(this.pet);
}

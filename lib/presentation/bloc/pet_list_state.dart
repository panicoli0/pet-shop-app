import 'package:pets_shop/domain/models/pet.dart';

abstract class PetListState {}

class PetListInitial extends PetListState {}

class PetListLoading extends PetListState {}

class PetListLoaded extends PetListState {
  final List<Pet> pets;
  PetListLoaded(this.pets);
}

class PetListError extends PetListState {
  final String message;
  PetListError(this.message);
}

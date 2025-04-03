import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

abstract class PetListState {}

class PetListInitial extends PetListState {}

class PetListLoading extends PetListState {}

class PetListLoaded extends PetListState {
  final List<PetEntity> pets;
  PetListLoaded(this.pets);
}

class PetListError extends PetListState {
  final String message;
  PetListError(this.message);
}

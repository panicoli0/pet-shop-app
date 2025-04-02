import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/data/repository/pet_repository.dart';
import 'package:pets_shop/domain/models/pet.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  final IPetRepository repository;

  PetListBloc({required this.repository}) : super(PetListInitial()) {
    on<LoadPets>(_onLoadPets);
    on<SearchPets>(_onSearchPets);
    on<FilterPetsByBreed>(_onFilterPetsByBreed);
    on<AddPet>(_onAddPet);
  }

  Future<void> _onLoadPets(LoadPets event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    try {
      final pets = await repository.getPets();
      emit(PetListLoaded(pets));
    } catch (e) {
      emit(PetListError('Failed to load pets: $e'));
    }
  }

  // ... other event handlers
  Future<void> _onSearchPets(
      SearchPets event, Emitter<PetListState> emit) async {
    if (state is PetListLoaded) {
      final currentState = state as PetListLoaded;
      final filteredPets = currentState.pets
          .where((pet) =>
              pet.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(PetListLoaded(filteredPets));
    }
  }

  Future<void> _onFilterPetsByBreed(
      FilterPetsByBreed event, Emitter<PetListState> emit) async {
    if (state is PetListLoaded) {
      final currentState = state as PetListLoaded;
      final filteredPets = currentState.pets
          .where((pet) => pet.breed.toLowerCase() == event.breed.toLowerCase())
          .toList();
      emit(PetListLoaded(filteredPets));
    }
  }

  Future<void> _onAddPet(AddPet event, Emitter<PetListState> emit) async {
    if (state is PetListLoaded) {
      final currentState = state as PetListLoaded;
      final updatedPets = List<Pet>.from(currentState.pets)..add(event.pet);
      emit(PetListLoaded(updatedPets));
    }
  }
  // Add as many event handlers as needed:
  // For example, you can add handlers for updating or deleting pets
}

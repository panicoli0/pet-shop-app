import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/domain/usecases/get_pets.dart';
import 'package:pets_shop/domain/usecases/search_pets.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  final GetPetsUseCase getPetsUseCase;
  final SearchPetsUseCase searchPetsUseCase;

  PetListBloc({
    required this.getPetsUseCase,
    required this.searchPetsUseCase,
  }) : super(PetListInitial()) {
    on<LoadPets>(_onLoadPets);
    on<SearchPets>(_onSearchPets);
    on<FilterPetsByBreed>(_onFilterPetsByBreed);
    on<AddPet>(_onAddPet);
  }

  Future<void> _onLoadPets(LoadPets event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    try {
      final pets = await getPetsUseCase();
      emit(PetListLoaded(pets));
    } catch (e) {
      emit(PetListError('Failed to load pets: $e'));
    }
  }

  Future<void> _onSearchPets(
      SearchPets event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    try {
      final pets = await searchPetsUseCase(event.query);
      emit(PetListLoaded(pets));
    } catch (e) {
      emit(PetListError('Failed to search pets: $e'));
    }
  }

  Future<void> _onFilterPetsByBreed(
      FilterPetsByBreed event, Emitter<PetListState> emit) async {
    if (state is PetListLoaded) {
      final currentState = state as PetListLoaded;
      final filteredPets = currentState.pets
          .where((pet) => pet.breed!.toLowerCase() == event.breed.toLowerCase())
          .toList();
      emit(PetListLoaded(filteredPets));
    }
  }

  Future<void> _onAddPet(AddPet event, Emitter<PetListState> emit) async {
    if (state is PetListLoaded) {
      final currentState = state as PetListLoaded;
      final updatedPets = List<PetEntity>.from(currentState.pets)
        ..add(event.pet);
      emit(PetListLoaded(updatedPets));
    }
  }
}

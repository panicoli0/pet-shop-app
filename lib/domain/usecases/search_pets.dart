import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';

class SearchPetsUseCase {
  final IPetRepository repository;

  SearchPetsUseCase(this.repository);

  Future<List<PetEntity>> call(String query) async =>
      await repository.searchPets(query);
}

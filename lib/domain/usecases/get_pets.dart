import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';

class GetPetsUseCase {
  final IPetRepository repository;

  GetPetsUseCase(this.repository);

  Future<List<PetEntity>> call() => repository.getPets();
}

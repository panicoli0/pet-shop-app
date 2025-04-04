import 'package:pets_shop/data/models/pet_model.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

abstract class IPetLocalDataSource {
  Future<List<PetEntity>> getPets();
  Future<void> cachePets(List<PetEntity> pets);
}

class PetLocalDataSource implements IPetLocalDataSource {
  final List<PetModel> _cache = [];

  @override
  Future<List<PetEntity>> getPets() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _cache; // PetModel extends PetEntity, so this is valid
  }

  @override
  Future<void> cachePets(List<PetEntity> pets) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cache
      ..clear()
      ..addAll(pets.map((pet) => PetModel(
            id: pet.id,
            name: pet.name,
            breed: pet.breed,
            age: pet.age,
            imageUrl: pet.imageUrl,
          )));
  }
}

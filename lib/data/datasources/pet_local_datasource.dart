import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

abstract class IPetLocalDataSource {
  Future<List<PetEntity>> getPets();
  Future<void> cachePets(List<PetEntity> pets);
}

class PetLocalDataSource implements IPetLocalDataSource {
  final List<PetEntity> _cache = [];

  @override
  Future<List<PetEntity>> getPets() async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // Simulate disk read
    return _cache;
  }

  @override
  Future<void> cachePets(List<PetEntity> pets) async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // Simulate disk write
    _cache
      ..clear()
      ..addAll(pets);
  }
}

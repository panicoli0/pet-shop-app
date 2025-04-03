import 'package:flutter/foundation.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class PetShopService extends ChangeNotifier {
  final List<PetEntity> _pets = [
    PetEntity(
      id: 1,
      name: 'Buddy',
      breed: 'Golden Retriever',
      age: 3,
      imageUrl: 'resources/images/buddy2.jpeg',
    ),
    PetEntity(
        id: 2,
        name: 'Whiskers',
        breed: 'Siamese',
        age: 1,
        imageUrl: 'resources/images/cat1.jpeg'),
  ];

  List<PetEntity> get pets => _pets;

  void addPet(PetEntity pet) {
    _pets.add(pet);
    notifyListeners(); // Important: Notify listeners of the change!
  }
}

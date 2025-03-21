import 'package:flutter/foundation.dart';
import 'package:pets_shop/models/pet.dart';

class PetShopService extends ChangeNotifier {
  final List<Pet> _pets = [
    Pet(
      name: 'Buddy',
      breed: 'Golden Retriever',
      age: 3,
      imageUrl: 'resources/images/buddy2.jpeg',
    ),
    Pet(
        name: 'Whiskers',
        breed: 'Siamese',
        age: 1,
        imageUrl: 'resources/images/cat1.jpeg'),
  ];

  List<Pet> get pets => _pets;

  void addPet(Pet pet) {
    _pets.add(pet);
    notifyListeners(); // Important: Notify listeners of the change!
  }
}

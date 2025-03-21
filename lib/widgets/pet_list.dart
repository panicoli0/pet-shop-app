// filepath: lib/widgets/pet_list.dart (initial branch - refactored with Provider)
import 'package:flutter/material.dart';
import 'package:pets_shop/services/pet_shop_service.dart';
import 'package:provider/provider.dart';

class PetList extends StatelessWidget {
  const PetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PetShopService>(
      builder: (context, petShopService, child) {
        return ListView.builder(
          itemCount: petShopService.pets.length,
          itemBuilder: (context, index) {
            final pet = petShopService.pets[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(pet.imageUrl),
              ),
              title: Text(pet.name),
              subtitle: Text(pet.breed),
            );
          },
        );
      },
    );
  }
}

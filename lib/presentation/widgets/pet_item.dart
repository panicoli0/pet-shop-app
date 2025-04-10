import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/domain/entities_DTOs/cart_item_entity.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';
import 'package:pets_shop/presentation/bloc/cart/bloc/cart_bloc.dart';

class PetItem extends StatelessWidget {
  const PetItem({
    super.key,
    required this.pet,
    required this.onPetSelected,
  });

  final PetEntity pet;
  final Function(PetEntity pet)? onPetSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(pet.imageUrl!),
      ),
      title: Text(pet.name!),
      subtitle: Text(pet.breed!),
      onTap: () => onPetSelected?.call(pet),
      trailing: IconButton(
        icon: const Icon(Icons.add_shopping_cart),
        onPressed: () {
          context.read<CartBloc>().add(
                AddToCart(
                  CartItemEntity(
                    id: pet.id,
                    name: pet.name!,
                    description: pet.breed!,
                    price: 29.99,
                    quantity: 1,
                    imageUrl: pet.imageUrl!,
                  ),
                ),
              );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${pet.name} added to cart'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}

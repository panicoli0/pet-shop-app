import 'package:flutter/material.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetEntity pet;

  const PetDetailsScreen({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name ?? 'Loading...'),
      ),
      body: pet.name == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pet.imageUrl != null)
                    Hero(
                      tag: 'pet_${pet.id}',
                      child: Image.asset(
                        pet.imageUrl!,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name ?? '',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        if (pet.breed != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Breed: ${pet.breed}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                        if (pet.age != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Age: ${pet.age} years',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

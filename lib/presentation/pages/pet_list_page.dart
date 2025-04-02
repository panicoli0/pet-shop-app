import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetListBloc, PetListState>(
      builder: (context, state) {
        if (state is PetListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PetListError) {
          return Center(child: Text(state.message));
        }

        if (state is PetListLoaded) {
          return ListView.builder(
            itemCount: state.pets.length,
            itemBuilder: (context, index) {
              final pet = state.pets[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(pet.imageUrl),
                ),
                title: Text(pet.name),
                subtitle: Text(pet.breed),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

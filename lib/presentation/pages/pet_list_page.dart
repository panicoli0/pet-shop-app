import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final petListBloc = context.read<PetListBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Shop'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: 'Search pets by name or breed...',
              onChanged: (query) {
                if (query.isEmpty) {
                  petListBloc.add(LoadPets());
                } else {
                  petListBloc.add(SearchPets(query));
                }
              },
              leading: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: BlocBuilder<PetListBloc, PetListState>(
        builder: (context, state) {
          if (state is PetListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PetListError) {
            return Center(child: Text(state.message));
          }

          if (state is PetListLoaded) {
            if (state.pets.isEmpty) {
              return const Center(
                child: Text('No pets found'),
              );
            }

            return ListView.builder(
              itemCount: state.pets.length,
              itemBuilder: (context, index) {
                final pet = state.pets[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pet.imageUrl),
                  ),
                  title: Text(pet.name),
                  subtitle: Text(pet.breed),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

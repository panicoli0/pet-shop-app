import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';
import 'package:pets_shop/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/widgets/pet_item.dart';

class PetListPage extends StatelessWidget {
  final Function(PetEntity)? onPetSelected;
  final Function()? onCartTapped;

  const PetListPage({
    super.key,
    this.onPetSelected,
    this.onCartTapped,
  });

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
                return PetItem(pet: pet, onPetSelected: onPetSelected);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) return const SizedBox.shrink();

          return Stack(children: [
            FloatingActionButton(
              onPressed: onCartTapped,
              child: const Icon(Icons.shopping_cart),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.pink[500],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${state.totalItems}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    decorationThickness: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/di/injection.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/pages/pet_list_page.dart';

void main() {
  // Initialize dependencies
  initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PetListBloc>()..add(LoadPets()),
        ),
      ],
      child: const PetShopApp(),
    ),
  );
}

class PetShopApp extends StatelessWidget {
  const PetShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pet Shop',
      home: Scaffold(
        body: PetListPage(),
      ),
    );
  }
}

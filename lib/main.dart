import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/app.dart';
import 'package:pets_shop/di/injection.dart';
import 'package:pets_shop/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';

void main() {
  initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PetListBloc>()..add(LoadPets()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: const PetShopApp(),
    ),
  );
}

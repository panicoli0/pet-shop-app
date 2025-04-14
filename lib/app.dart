import 'package:flutter/material.dart';
import 'package:pets_shop/core/config/routes/pet_route_information_parser.dart';
import 'package:pets_shop/core/config/routes/pet_router_delegate.dart';

class PetShopApp extends StatefulWidget {
  const PetShopApp({super.key});

  @override
  State<PetShopApp> createState() => _PetShopAppState();
}

class _PetShopAppState extends State<PetShopApp> {
  final _routerDelegate = PetRouterDelegate();
  final _routeInformationParser = PetRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pet Shop',
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

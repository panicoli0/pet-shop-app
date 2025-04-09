import 'package:flutter/material.dart';
import 'package:pets_shop/presentation/pages/cart_page.dart';
import 'package:pets_shop/presentation/pages/pet_list_page.dart';

class PetShopApp extends StatelessWidget {
  const PetShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Shop',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PetListPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}

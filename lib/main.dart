import 'package:flutter/material.dart';
import 'package:pets_shop/services/pet_shop_service.dart';
import 'package:pets_shop/widgets/pet_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PetShopService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Shop',
      home: Scaffold(
        appBar: AppBar(title: const Text('Pet Shop')),
        body: const PetList(),
      ),
    );
  }
}

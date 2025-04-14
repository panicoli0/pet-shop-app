import 'package:flutter/material.dart';
import 'package:pets_shop/app.dart';
import 'package:pets_shop/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const PetShopApp());
}

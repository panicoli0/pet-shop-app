import 'package:hive_flutter/hive_flutter.dart';
import 'package:pets_shop/domain/adapters/cart_item_adapter.dart';
import 'package:pets_shop/domain/entities_DTOs/cart_item_entity.dart';

class HiveService {
  static const String cartBox = 'cart';

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItemEntity>(cartBox);
  }

  Box<CartItemEntity> getCartBox() {
    return Hive.box<CartItemEntity>(cartBox);
  }

  Future<void> closeHive() async {
    await Hive.close();
  }
}

import 'dart:async';
import 'package:hive/hive.dart';
import 'package:pets_shop/data/services/hive_service.dart';
import 'package:pets_shop/domain/entities_DTOs/cart_item_entity.dart';
import 'package:pets_shop/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements ICartRepository {
  final HiveService _hiveService;
  final _cartController =
      StreamController<Map<int, CartItemEntity>>.broadcast();

  CartRepositoryImpl(this._hiveService);

  Box<CartItemEntity> get _cartBox => _hiveService.getCartBox();

  @override
  Stream<Map<int, CartItemEntity>> getCartItemsStream() =>
      _cartController.stream;

  @override
  Future<Map<int, CartItemEntity>> getCartItems() async {
    final items = _cartBox.toMap();
    return Map<int, CartItemEntity>.from(items);
  }

  @override
  Future<void> addItem(CartItemEntity item) async {
    await _cartBox.put(item.id, item);
    _notifyCartChanged();
  }

  @override
  Future<void> updateItemQuantity(int itemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(itemId);
      return;
    }

    final item = _cartBox.get(itemId);
    if (item != null) {
      final updatedItem = CartItemEntity(
        id: item.id,
        name: item.name,
        description: item.description,
        price: item.price,
        quantity: quantity,
        imageUrl: item.imageUrl,
      );
      await _cartBox.put(itemId, updatedItem);
      _notifyCartChanged();
    }
  }

  @override
  Future<void> removeItem(int itemId) async {
    await _cartBox.delete(itemId);
    _notifyCartChanged();
  }

  @override
  Future<void> clearCart() async {
    await _cartBox.clear();
    _notifyCartChanged();
  }

  void _notifyCartChanged() async {
    final items = await getCartItems();
    _cartController.add(items);
  }

  void dispose() {
    _cartController.close();
  }
}

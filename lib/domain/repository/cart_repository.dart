import '../entities_DTOs/cart_item_entity.dart';

abstract class ICartRepository {
  Stream<Map<int, CartItemEntity>> getCartItemsStream();
  Future<Map<int, CartItemEntity>> getCartItems();
  Future<void> addItem(CartItemEntity item);
  Future<void> updateItemQuantity(int itemId, int quantity);
  Future<void> removeItem(int itemId);
  Future<void> clearCart();
}

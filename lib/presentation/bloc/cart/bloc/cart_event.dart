part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItemEntity item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final int itemId;
  RemoveFromCart(this.itemId);
}

class UpdateQuantity extends CartEvent {
  final int itemId;
  final int quantity;
  UpdateQuantity(this.itemId, this.quantity);
}

class ClearCart extends CartEvent {}

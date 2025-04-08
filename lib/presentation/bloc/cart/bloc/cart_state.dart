part of 'cart_bloc.dart';

final class CartInitial extends CartState {}

class CartState {
  final Map<int, CartItemEntity> items;

  CartState({
    this.items = const {},
  });

  double get total => items.values.fold(0, (sum, item) => sum + item.total);
  int get totalItems =>
      items.values.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    Map<int, CartItemEntity>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}

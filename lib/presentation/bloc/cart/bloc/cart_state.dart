part of 'cart_bloc.dart';

class CartState {
  final Map<int, CartItemEntity> items;
  final double total;
  final int totalItems;
  final bool isLoading;
  final String? error;

  const CartState({
    this.items = const {},
    this.total = 0,
    this.totalItems = 0,
    this.isLoading = false,
    this.error,
  });

  factory CartState.initial() => const CartState();

  CartState copyWith({
    Map<int, CartItemEntity>? items,
    double? total,
    int? totalItems,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      total: total ?? this.total,
      totalItems: totalItems ?? this.totalItems,
      isLoading: isLoading ?? this.isLoading,
      error: error, // Pass null to clear error
    );
  }

  @override
  String toString() {
    return 'CartState(items: ${items.length}, total: $total, totalItems: $totalItems, isLoading: $isLoading, error: $error)';
  }
}

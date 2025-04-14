import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pets_shop/domain/entities_DTOs/cart_item_entity.dart';
import 'package:pets_shop/domain/repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository;
  late final StreamSubscription _cartSubscription;

  CartBloc(this._cartRepository) : super(CartState.initial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);

    // Auto-load cart when bloc is created
    add(LoadCart());

    // Listen to cart changes
    _cartSubscription = _cartRepository.getCartItemsStream().listen((items) {
      if (!isClosed) {
        add(LoadCart());
      }
    });
  }

  @override
  Future<void> close() {
    _cartSubscription.cancel();
    return super.close();
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final items = await _cartRepository.getCartItems();

      // Calculate total price
      double total = items.values.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      // Calculate total items
      int totalItems = items.values.fold(
        0,
        (sum, item) => sum + item.quantity,
      );

      emit(
        state.copyWith(
          items: items,
          total: total,
          totalItems: totalItems,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          items: const {},
          total: 0,
          totalItems: 0,
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.addItem(event.item);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onUpdateQuantity(
      UpdateQuantity event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.updateItemQuantity(event.itemId, event.quantity);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.removeItem(event.itemId);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.clearCart();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

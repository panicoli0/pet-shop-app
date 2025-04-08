import 'package:bloc/bloc.dart';
import 'package:pets_shop/domain/entities_DTOs/cart_item_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    // Create a new map with deep copies of all items
    final updatedItems = Map<int, CartItemEntity>.fromEntries(
      state.items.entries.map(
        (entry) => MapEntry(
          entry.key,
          entry.value.copyWith(),
        ),
      ),
    );

    if (updatedItems.containsKey(event.item.id)) {
      final existingItem = updatedItems[event.item.id]!;
      updatedItems[event.item.id] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedItems[event.item.id] = event.item;
    }
    emit(state.copyWith(items: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    // Create a deep copy before removing
    final updatedItems = state.items.map(
      (key, value) => MapEntry(
        key,
        CartItemEntity(
          id: value.id,
          name: value.name,
          description: value.description,
          price: value.price,
          quantity: value.quantity,
          imageUrl: value.imageUrl,
        ),
      ),
    )..remove(event.itemId);

    emit(state.copyWith(items: updatedItems));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    if (!state.items.containsKey(event.itemId)) return;

    // Create a new map with deep copies of all items
    final updatedItems = Map<int, CartItemEntity>.fromEntries(
      state.items.entries.map(
        (entry) => MapEntry(
          entry.key,
          entry.value.copyWith(),
        ),
      ),
    );

    if (event.quantity <= 0) {
      updatedItems.remove(event.itemId);
    } else {
      final item = updatedItems[event.itemId]!;
      updatedItems[event.itemId] = item.copyWith(
        quantity: event.quantity,
      );
    }

    emit(state.copyWith(items: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(items: {}));
  }
}

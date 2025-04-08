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
    final updatedItems = Map<int, CartItemEntity>.from(state.items);
    if (updatedItems.containsKey(event.item.id)) {
      final existingItem = updatedItems[event.item.id]!;
      updatedItems[event.item.id] = CartItemEntity(
        id: existingItem.id,
        name: existingItem.name,
        description: existingItem.description,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
        imageUrl: existingItem.imageUrl,
      );
    } else {
      updatedItems[event.item.id] = event.item;
    }
    emit(state.copyWith(items: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = Map<int, CartItemEntity>.from(state.items)
      ..remove(event.itemId);
    emit(state.copyWith(items: updatedItems));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    if (!state.items.containsKey(event.itemId)) return;

    final updatedItems = Map<int, CartItemEntity>.from(state.items);
    final item = updatedItems[event.itemId]!;

    if (event.quantity <= 0) {
      updatedItems.remove(event.itemId);
    } else {
      updatedItems[event.itemId] = CartItemEntity(
        id: item.id,
        name: item.name,
        description: item.description,
        price: item.price,
        quantity: event.quantity,
        imageUrl: item.imageUrl,
      );
    }

    emit(state.copyWith(items: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(items: {}));
  }
}

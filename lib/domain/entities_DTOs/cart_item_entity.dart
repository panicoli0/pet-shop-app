import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;

  const CartItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  CartItemEntity copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  double get total => price * quantity;

  @override
  List<Object?> get props => [id, name, description, price, quantity, imageUrl];
}

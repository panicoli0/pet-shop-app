class CartItemEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  double get total => price * quantity;
}

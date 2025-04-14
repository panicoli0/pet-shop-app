import 'package:hive/hive.dart';
import 'package:pets_shop/domain/entities_DTOs/cart_item_entity.dart';

class CartItemAdapter extends TypeAdapter<CartItemEntity> {
  @override
  final int typeId = 1;

  @override
  CartItemEntity read(BinaryReader reader) {
    return CartItemEntity(
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      price: reader.read(),
      quantity: reader.read(),
      imageUrl: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItemEntity obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.price);
    writer.write(obj.quantity);
    writer.write(obj.imageUrl);
  }
}

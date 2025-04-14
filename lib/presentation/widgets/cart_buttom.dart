import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shop/di/injection.dart';
import 'package:pets_shop/presentation/bloc/cart/bloc/cart_bloc.dart';

class CartButton extends StatelessWidget {
  final Function()? onCartTapped;

  const CartButton({
    super.key,
    required this.onCartTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartBloc>(),
      child: CartButtonView(onCartTapped: onCartTapped),
    );
  }
}

class CartButtonView extends StatelessWidget {
  const CartButtonView({
    super.key,
    required this.onCartTapped,
  });

  final Function()? onCartTapped;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Stack(
          children: [
            FloatingActionButton(
              onPressed: onCartTapped,
              child: const Icon(Icons.shopping_cart),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.pink[500],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${state.totalItems}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    decorationThickness: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartService>().cart;

    return Scaffold(
      //builder: (context, CartService, child) {
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Consumer<CartService>(
          builder: (context, cartService, child) {
            return ListView(
              children: cart.map(
                (e) => ListTile(
                title: Text(e.name ?? ''),
                subtitle: Text("USD ${e.price ?? ''}"),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    context.read<CartService>().removeFromCart(e);
                  },
                ),
                ),
              ).toList()
            );
          }
        )
      )
    );
  }
}

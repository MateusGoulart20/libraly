import 'package:flutter/material.dart';
import 'package:flutter_application/pages/cart/cart_page.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    var items = context.watch<CartService>().items;
    var cart = context.watch<CartService>().cart;
    return Scaffold(
      body: GridView.count(
        //crossAxisSpacing: 2,
        //mainAxisSpacing: 5,
        crossAxisCount: 6,
        children: items.map((e) => Card(
          child: ListTile(
                    title: Text(e.name ?? ''),
                    //leading: Text('a'),
                    subtitle: Text("USD ${e.price ?? ''}"),
                    trailing: IconButton(
                      icon: Icon(
                        cart.contains(e)
                            ? Icons.remove_circle
                            : Icons.add_circle,
                      ),
                      onPressed: () {
                        if (!cart.contains(e)) {
                          context.read<CartService>().addToCart(e);
                        } else {
                          context.read<CartService>().removeFromCart(e);
                        }
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
      floatingActionButton: cart.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              label: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 255, 29, 153),
                    ),
                    child: Text(cart.length.toString(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  const Text('Cart'),
                ],
              ),
            ),
    );
  }
}

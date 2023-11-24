import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/cart/cart_page.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:flutter_application/pages/home/filter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    var items = context.watch<CartService>().items;
    var cart = context.watch<CartService>().cart;
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClothingOptionsPanel(),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            StreamBuilder<QuerySnapshot>(
                stream: collectionItem,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return GridView.count(
                    crossAxisCount: 6,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Visibility(
                          visible: true,
                          child: Card(
                            child: GridTile(
                              header: Text(
                                data['name'],
                                textAlign: TextAlign.center,
                              ),
                              child: Icon(Icons.remove_circle_outline),
                              footer: Row(
                                children: [
                                  const Spacer(),
                                  Text('R\$ ${data['price']}'),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      //cart.contains(e)
                                      //? Icons.remove_circle
                                      //:
                                      Icons.add_circle,
                                    ),
                                    onPressed: () {
                                      //if (!cart.contains(e)) {
                                      //context.read<CartService>().addToCart(e);
                                      //} else {
                                      //  context.read<CartService>().removeFromCart(e);
                                      //}
                                    },
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ));
                    }).toList(),
                  ); // List View
                }), // Stream Builder
          ]),
        ],
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
    ); //Scaffold
  }
}

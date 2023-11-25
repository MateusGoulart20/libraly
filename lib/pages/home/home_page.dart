import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
import 'package:flutter_application/pages/cart/cart_page.dart';
import 'package:flutter_application/pages/home/lister.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:flutter_application/pages/home/filter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key /*, this.title*/});
  //final String? title;
  List<String> filtro = [];

  @override
  Widget build(BuildContext context) {
    //List<CartItem> carrinho = [];
    //var items = context.watch<CartService>().items;
    var cart = context.watch<CartService>().cart;
    return Scaffold(
      body: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.green.shade100,
              child:
                  //SizedBox.fromSize(
                  //size: const Size.fromHeight(20),
                  //child:
                  const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClothingOptionsPanel(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow.shade100,
              child: Listing(filtroInincial: []),
            ),
          ),
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

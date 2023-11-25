import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
import 'package:flutter_application/models/pedido/pedido.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:flutter_application/services/cart/pedido_service.dart';
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: cart
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(e.name ?? ''),
                          subtitle: Text("R\$ ${e.price ?? ''}"),
                          tileColor: Colors.indigo.shade100,
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {

                              context.read<CartService>().removeFromCart(e);
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total: R\$${context.read<CartService>().total().toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ElevatedButton(
              onPressed: cart.isNotEmpty
                  ? () => {
                    context.read<CartService>().finalizarCompra()
                    }
                  : null,
              // Defina a função `finalizarCompra` para processar a compra.
              // Se carrinho for vazio, o botão será desativado (onPressed: null).
              child: const Text('Finalizar Compra'),
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

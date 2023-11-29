import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
import 'package:flutter_application/services/cart/pedido_service.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    var items = context.watch<PedidoService>().items;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: items.map((e) {
                  return Container(
                    color: Colors.indigo.shade100,
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                        children: [
                          Text('${e.user.toString()} ${e.items.total().toStringAsFixed(2)}'),
                        ]),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

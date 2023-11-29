import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/cud/crud.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:flutter_application/pages/home/filter.dart';
import 'package:provider/provider.dart';

class CudPage extends StatelessWidget {
  const CudPage({super.key /*, this.title*/});
  //final String? title;

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
              child: const Cruding(filtroInincial: []),
            ),
          ),
        ],
      ),
      floatingActionButton: //cart.isEmpty ? null :
        FloatingActionButton(
            onPressed: (){
                  showInsertDialog(context);
            },
              /*onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },*/
              child: const Icon(Icons.add),
              /*label: Row(
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
              ),*/
            ),
    ); //Scaffold
  }
}

void showInsertDialog(BuildContext context) async {
  TextEditingController nomeController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Novo Produto'),
        content: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Preço'),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fechar o diálogo
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Implementar lógica de inserção no Firebase
              FirebaseFirestore.instance.collection('item').add({
                'name': nomeController.text,
                'price': double.parse(priceController.text),
                'tipo': tipoController.text,
              });

              Navigator.of(context).pop(); // Fechar o diálogo
            },
            child: const Text('Inserir'),
          ),
        ],
      );
    },
  );
}

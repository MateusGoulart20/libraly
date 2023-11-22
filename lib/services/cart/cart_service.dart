import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CartService with ChangeNotifier {
  final List<CartItem> _items = getItems();
  //chartService.getItems() as List<CartItem>;
  final List<CartItem> _cart = [];

  List<CartItem> get items => _items;

  List<CartItem> get cart => _cart;

  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }
  
}

class Grid extends StatelessWidget {
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: _firestore.collection('item').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
         List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              // Aqui você pode criar um widget para exibir os detalhes do item
              String itemName = documents[index]['name'] ?? 'Sem nome';
              String itemDescription = documents[index]['description'] ?? 'Sem descrição';

              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(itemName),
                    Text(itemDescription),
                    // Adicione outros widgets conforme necessário
                  ],
                ),
              );
            },
          );
      }
      
      );
  }

}
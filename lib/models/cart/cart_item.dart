//import 'package:flutter/material.dart';

List<CartItem> listChart = [];

class CartItem {
  final String? name;
  final double? price;
  final String? tipo;
  int? qtd; // quantidade

  CartItem({this.name, this.price, this.tipo, this.qtd});
}

List<CartItem> getItems(){
  return [
    CartItem(name: 'Teclado ', price: 24, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'Mouse', price: 20, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'Monitor LED', price: 44, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'Macbook Air', price: 240, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'Samsung', price: 204, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'iMac', price: 248, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'Headphones', price: 29, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'Disco USB', price: 19, tipo: 'Eletronico', qtd: 1),
    CartItem(name: 'SSD', price: 23, tipo: 'Eletronico', qtd: 1),
  ];}


/*
  Future<List<CartItem>> getItems() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('item').get();

    List<CartItem> items = querySnapshot.docs.map((doc) {
      return CartItem(
        name: doc['name'],
        price: doc['price'],
      );
    }).toList();

    return items;
  }
*/


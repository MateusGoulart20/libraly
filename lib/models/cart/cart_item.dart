import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

List<CartItem> listChart = [];

class CartItem {
  final String? name;
  final String? price;

  CartItem({this.name, this.price});
}
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
/*/
//*
  List<CartItem> getItems(){
  return [
    CartItem(name: 'Teclado ', price: '24'),
    CartItem(name: 'Mouse', price: '20'),
    CartItem(name: 'Monitor LED', price: '44'),
    CartItem(name: 'Macbook Air', price: '240'),
    CartItem(name: 'Samsung', price: '204'),
    CartItem(name: 'iMac', price: '248'),
    CartItem(name: 'Headphones', price: '29'),
    CartItem(name: 'Disco USB', price: '19'),
    CartItem(name: 'SSD', price: '23'),
  ];}
//*/

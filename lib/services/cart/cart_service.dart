import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
import 'package:flutter_application/models/pedido/pedido.dart';
import 'package:flutter_application/services/cart/pedido_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CartService with ChangeNotifier {
  static final CartService _instancia = CartService._();
  static PedidoService? pedidos = PedidoService.instanciar();

  @override
  CartService._();
  
  static CartService instanciar(){
    return _instancia;
  }
 

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

  //List<Order> pedidos =
  //Order pedidoFeito = Order();

  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.removeAt(_cart.indexOf(item));
    notifyListeners();
  }

  void finalizarCompra(){
    pedidos?.addPedido(Pedido(user: 'a',items: _cart));

    //context.read<CartService>().finalizarCompra()
    _cart = [];
    notifyListeners();
  }

  void removeItemCart(CartItem item){
    for (CartItem elemento in _cart) {
      if (igualdade(elemento, item)) {
        _cart.remove(elemento);
      }
    }
    notifyListeners();
  }

  int contagem(CartItem elementoEntrada) {
    int contador = 0;

    for (CartItem elemento in _cart) {
      if (igualdade(elemento, elementoEntrada)) {
        contador++;
      }
    }

    return contador;
  }

  bool igualdade(CartItem elemento1, CartItem elemento2) {
    return (elemento1.name == elemento2.name);
  }

  double total() { 
    return cart.total();
  }
}

Stream<QuerySnapshot> collectionItem =
    _firestore.collection('item').snapshots();

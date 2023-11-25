import 'package:flutter_application/models/cart/cart_item.dart';

class Pedido {
  String user;
  List<CartItem> items;

  Pedido({required this.user, required this.items});

  Map<String, dynamic> toMap() {
    return {'user': user, 'items': items};
  }
}

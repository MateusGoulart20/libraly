import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
import 'package:flutter_application/models/pedido/pedido.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:flutter_application/services/users/users_services.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class PedidoService with ChangeNotifier {
  static final PedidoService? _instancia = PedidoService._();

  @override
  PedidoService._();
  
  static PedidoService? instanciar(){
    return _instancia;
  }

  
  
  /*
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserServices _userService = UserServices();

  Future<List<Pedido>> getPedidosDoUsuario(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('pedidos')
          .where('user', isEqualTo: context.read<UsersServices>.users!.userName!)
          .get();

      List<Pedido> pedidos = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()!;
        return Pedido(
          user: data['user'],
          //items: List<String>.from(data['items']),
        );
      }).toList();

      return pedidos;
    } catch (e) {
      print('Erro ao obter pedidos do usuário: $e');
      return [];
    }
  }

*/
  final List<Pedido> _items = [
    Pedido(user: 'a', items: [CartItem(name: 'Gost', price: 200)])
  ];
  List<Pedido> get items => _items;
  CartService? cartService = CartService.instanciar();

  void addPedido(Pedido item) {
    _items.add(Pedido (user: item.user, items: item.items));
    //cartService?.finalizarCompra();
    //context.read<CartService>().finalizarCompra()
    notifyListeners();
  }

  void removePedido(Pedido item) {
    _items.remove(item);
    notifyListeners();
  }
  
}

Stream<QuerySnapshot> collectionItem =
    _firestore.collection('pedidos').snapshots();
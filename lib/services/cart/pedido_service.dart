import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/pedido/pedido.dart';
import 'package:flutter_application/services/cart/cart_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class PedidoService with ChangeNotifier {
  static final PedidoService _instancia = PedidoService._();
  CollectionReference pedidoFire = _firestore.collection('pedidos');

  
  @override
  PedidoService._();
  
  static PedidoService? instanciar(){
    return _instancia;
  }

  Future<List<String>> getFire() async {
    var snapshot = await pedidoFire.get();
    return snapshot.docs.map((doc) => doc['item'] as String).toList();
  }
  
  /*
81  final UserServices _userService = UserServices();

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
  List<Pedido> _items = [];
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
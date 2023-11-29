import 'package:flutter/material.dart';
import 'package:flutter_application/pages/cart/cart_page.dart';
import 'package:flutter_application/pages/home/home_page.dart';
import 'package:flutter_application/pages/order/order_page.dart';
import 'package:flutter_application/pages/userprofile/user_profile_page.dart';
import 'package:flutter_application/pages/cud/cud_page.dart';
//import 'package:provider/provider.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;



  @override
  Widget build(BuildContext context) {

  //var cart = context.watch<CartService>().cart;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xFFFF00FF),
        elevation: 2.0,
        title: const Text("Fashion Moda"),
      ),
      body: [
        const HomePage(),
        const CartPage(),
        const OrderPage(),
        const CudPage(),
        const UserProfilePage(),
      ][_index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (int position) {
            setState(() {
              _index = position;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Pedidos',
            ),
            NavigationDestination(
              icon: Icon(Icons.cloud_upload_rounded),
              label: 'CUD',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_box_outlined),
              label: 'Perfil de Usuário',
            )
          ]),
    );
  }
}

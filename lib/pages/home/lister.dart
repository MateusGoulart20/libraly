import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart/cart_item.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
import 'package:flutter_application/services/cart/filter_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var options = const FirebaseOptions(
    apiKey: "AIzaSyBd0JAUT7mFbPHBM4DqMhfWXTVjvhXiUZ4",
    projectId: "lp3-48f51",
    messagingSenderId: "531864488194",
    appId: "1:1085970376249:web:88d6cc28e2f6d14586cfe8",
    storageBucket: "lp3-48f51.appspot.com/",
  );
  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const Listagem(),
  );
}

class Listagem extends StatelessWidget {
  const Listagem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Checkbox Sample')),
        body: const Center(
          child: Listing(
            filtroInincial: [],
          ),
        ),
      ),
    );
  }
}

class Listing extends StatefulWidget {
  final List<String> filtroInincial;
  //final String nomeTipo;
  // Callback para notificar mudança
  //final Function(bool) onCheckboxChanged;

  const Listing({
    super.key,
    required this.filtroInincial,
    /*required this.nomeTipo, required this.onCheckboxChanged*/
  });

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterService>(builder: (context, filterService, child) {
      List<String> filtro = filterService.items;

      //List<String> filtro = context.watch<FilterService>().items;
      List<CartItem> carrinho = context.watch<CartService>().cart;
      //bool isChecked = false;

      // Função para atualizar os valores internos com base em uma nova lista.
      //void filtrar(List<String> novaLista) {
      // setState(() {
      //   filtro = novaLista;
      // });
      //}

      bool filtragem(String valor) {
        if (filtro.isEmpty) {
          return true; // Se a lista de filtros estiver vazia, tudo é considerado válido.
        }

        // Divida a string por vírgulas
        List<String> palavras = valor.split(',');

        // Verifique se todos os itens do filtro estão presentes na lista de palavras
        return filtro.every((item) => palavras.contains(item.trim()));
      }

      return StreamBuilder<QuerySnapshot>(
        stream: collectionItem,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<Widget> gridItems = [];

          for (var document in snapshot.data!.docs) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            bool isVisible = filtragem(data['tipo']);
            CartItem atual = CartItem(
                name: data['name'],
                price: data['price'],
                tipo: data['tipo'],
                qtd: 0);

            if (isVisible) {
              gridItems.add(Card(
                child: GridTile(
                  header: Container(
                    color: Colors.blue.shade400,
                    child: Text(
                      data['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  footer: Container(
                    color: Colors.blue.shade50,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text('R\$ ${data['price']}'),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: () {
                            context.read<CartService>().addToCart(atual);
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 29, 153),
                          ),
                          child: Text(
                            context.read<CartService>().contagem(atual).toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            context.read<CartService>().removeItemCart(atual);
                          },
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    color: Colors.orange,
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ));
            }
          }

          return GridView.count(
            crossAxisCount: 5,
            children: gridItems,
          );
        },
      );
      // Stream Builder
    });
  }
}

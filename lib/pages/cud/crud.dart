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
          child: Cruding(
            filtroInincial: [],
          ),
        ),
      ),
    );
  }
}

class Cruding extends StatefulWidget {
  final List<String> filtroInincial;
  //final String nomeTipo;
  // Callback para notificar mudança
  //final Function(bool) onCheckboxChanged;

  const Cruding({
    super.key,
    required this.filtroInincial,
    /*required this.nomeTipo, required this.onCheckboxChanged*/
  });

  @override
  State<Cruding> createState() => _ListingState();
}

class _ListingState extends State<Cruding> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterService>(builder: (context, filterService, child) {
      List<String> filtro = filterService.items;

      List<CartItem> carrinho = context.watch<CartService>().cart;
      // Apesar de parecer a opção que não está sendo usada essa opção está mantendo atualizado.
      

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
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditDialog(context, document);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDeleteDialog(context, document);
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

void showEditDialog(BuildContext context, DocumentSnapshot document) async {
  TextEditingController nomeController = TextEditingController(text: document['name']);
  TextEditingController tipoController = TextEditingController(text: document['tipo']);
  TextEditingController descricaoController = TextEditingController(text: document['price'].toString());

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar Produto'),
        content: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: descricaoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipos'),
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
              // Implementar lógica de atualização no Firebase
              document.reference.update({
                'name': nomeController.text,
                'tipo': tipoController.text,
                'price': double.parse(descricaoController.text),
              });

              Navigator.of(context).pop(); // Fechar o diálogo
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}

void showDeleteDialog(BuildContext context, DocumentSnapshot document) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir este item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fechar o diálogo
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Implementar lógica de exclusão no Firebase
              document.reference.delete();

              Navigator.of(context).pop(); // Fechar o diálogo
            },
            child: Text('Excluir'),
          ),
        ],
      );
    },
  );
}

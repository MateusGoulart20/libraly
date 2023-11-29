import 'dart:io';
//import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/commons/custom_textformfield.dart';
//import 'package:flutter_application/commons/dotted_border.dart';
import 'package:flutter_application/models/usuario/usuario.dart';
import 'package:flutter_application/services/users/users_services.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final TextEditingController _socialMedia = TextEditingController();

  File? _pickImage;
  //variável utilizada para obter, especificamente,  imagens da câmera do table/celular
  Uint8List webImage = Uint8List(8);
  //utilizando para armazenar imagens da galeria (plataforma web)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Image.asset(
                  'assets/images/logo_flutter.png',
                  height: 100,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Registre-se",
                        style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 213, 107, 8),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        'aplicativo multi-funcional',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 213, 93, 8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _pickImage == null || webImage.isEmpty
                      ? SizedBox(child: dottedBorder(color: Colors.blue))
                      : ClipOval(
                          child: kIsWeb
                              ? Image.memory(
                                  height: 100,
                                  width: 100,
                                  webImage,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  _pickImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                        ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: _userName,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text("Nome do usuário"),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text("E-mail"),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                enabled: true,
                labelText: const Text('Telefone'),
                controller: _phone,
                prefixIcon: Icons.phone_enabled,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                enabled: true,
                labelText: const Text('Data de Nascimento'),
                controller: _birthday,
                prefixIcon: Icons.calendar_month,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                enabled: true,
                labelText: const Text('Rede Social'),
                controller: _socialMedia,
                prefixIcon: Icons.calendar_month,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    label: Text("Senha"),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      UsersServices usersServices = UsersServices();
                      Usuario users = Usuario();
                      users.email = _email.text;
                      users.userName = _userName.text;
                      users.password = _password.text;
                      users.birthday = _birthday.text;
                      users.socialMedia = _socialMedia.text;
                      users.phone = _phone.text;

                      if (await usersServices.signUp(
                          users, kIsWeb ? webImage : _pickImage, kIsWeb)) {
                        if (context.mounted) Navigator.of(context).pop();
                      } else {
                        if (context.mounted) {
                          var snackBar = const SnackBar(
                            content: Text('Algum erro aconteceu no registro'),
                            backgroundColor: Color.fromARGB(255, 161, 71, 66),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(50),
                            elevation: 20,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 1.5,
                        minimumSize: const Size.fromHeight(50),
                        shape: LinearBorder.bottom()),
                    child: const Text(
                      'Registrar',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Ou',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 50,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Login com Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Já tem uma conta?'),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dottedBorder({Color? color}) {
    return DottedBorder(
        dashPattern: const [5],
        color: color!,
        child: Column(
          children: [
            IconButton(
              iconSize: 80,
              icon: const Icon(Icons.image_search_rounded),
              onPressed: () {
                _pickedImage();
              },
            ),
            Text(
              "Foto",
              style: TextStyle(color: color),
            )
          ],
        ));
  }

  _pickedImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image;
    var imageSelected;
    if (!kIsWeb) {
      image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageSelected = File(image.path);
        setState(() {
          _pickImage = imageSelected;
        });
      }
    } else if (kIsWeb) {
      image = await picker.pickImage(
          source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
      if (image != null) {
        imageSelected = await image.readAsBytes();
        setState(() {
          webImage = imageSelected;
          _pickImage = File('a');
        });
      }
    }
  }
}

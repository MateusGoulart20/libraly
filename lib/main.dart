import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/users/users.dart';
import 'package:flutter_application/pages/authentication/login_page.dart';
import 'package:flutter_application/pages/cart/cart_page.dart';
import 'package:flutter_application/pages/main/main_page.dart';
import 'package:flutter_application/pages/userprofile/user_profile_edit_page.dart';
import 'package:flutter_application/pages/userprofile/user_profile_page.dart';
import 'package:flutter_application/services/users/users_services.dart';
import 'package:flutter_application/services/cart/cart_service.dart';
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
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UsersServices(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CartService(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorSchemeSeed: const Color.fromARGB(255, 1, 40, 3),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/mainpage': (context) => const MainPage(),
          '/userprofile': (context) => const UserProfilePage(),
          '/userprofileedit': (context) => const UserProfileEditPage(),
          '/cartpage': (context) => const CartPage()
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case '/mainpage':
              return MaterialPageRoute(builder: (_) => const MainPage());
            case '/userprofile':
              return MaterialPageRoute(builder: (_) => const UserProfilePage());
            case '/userprofileedit':
              return MaterialPageRoute(
                  builder: (_) =>
                      UserProfileEditPage(users: settings.arguments as Users));
            case '/cartpage':
              return MaterialPageRoute(builder: (_) => const CartPage());
          }
          return null;
        },
      ),
    );
  }
}




// // // main.dart
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'dart:io';
// // import 'package:image_picker/image_picker.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       // Hide the debug banner
// //       debugShowCheckedModeBanner: false,
// //       title: 'albertosales.com',
// //       home: HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget {
// //   const HomePage({Key? key}) : super(key: key);

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   // This is the file that will be used to store the image
// //   File? _image;
// //   Uint8List webImage = Uint8List(8);
// //   // This is the image picker
// //   final _picker = ImagePicker();
// //   // Implementing the image picker
// //   Future<void> _openImagePicker() async {
// //     if (!kIsWeb) {
// //       final XFile? pickedImage =
// //           await _picker.pickImage(source: ImageSource.gallery);
// //       if (pickedImage != null) {
// //         setState(() {
// //           _image = File(pickedImage.path);
// //         });
// //       }
// //     } else if (kIsWeb) {
// //       XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// //       if (image != null) {
// //         var imageSelected =
// //             await image.readAsBytes(); //converte a imagem para bytes
// //         setState(() {
// //           webImage = imageSelected;
// //           _image = File('a');
// //         });
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: const Text('albertosales.com'),
// //         ),
// //         body: SafeArea(
// //           child: Padding(
// //             padding: const EdgeInsets.all(35),
// //             child: Column(children: [
// //               Center(
// //                 // this button is used to open the image picker
// //                 child: ElevatedButton(
// //                   onPressed: _openImagePicker,
// //                   child: const Text('Selecione uma Imagem'),
// //                 ),
// //               ),
// //               const SizedBox(height: 35),
// //               // The picked image will be displayed here
// //               Container(
// //                 alignment: Alignment.center,
// //                 width: double.infinity,
// //                 height: 300,
// //                 color: Colors.grey[300],
// //                 child: ClipOval(
// //                   // borderRadius: BorderRadius.circular(12),
// //                   child: kIsWeb
// //                       ? Image.memory(
// //                           webImage,
// //                           height: 80,
// //                           width: 80,
// //                           fit: BoxFit.cover,
// //                         )
// //                       : Image.file(
// //                           _image!,
// //                           height: 80,
// //                           width: 80,
// //                           fit: BoxFit.cover,
// //                         ),
// //                 ),
// //               )
// //             ]),
// //           ),
// //         ));
// //   }
// // }

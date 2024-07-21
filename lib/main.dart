import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// ------------- Delete below ----------------------------
// import 'package:flutter/material.dart';
// import 'package:piggytech/admin/admin_drawer_list.dart';
//
// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   initialRoute: '/admin',
//   routes: {
//     '/admin' : (context) => AdminDrawerList(),
//   },
// ));
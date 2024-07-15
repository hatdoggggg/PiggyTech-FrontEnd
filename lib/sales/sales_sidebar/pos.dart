import 'package:flutter/material.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("pos page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
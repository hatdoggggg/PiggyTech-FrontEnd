import 'package:flutter/material.dart';

class SalesDrawerHeader extends StatefulWidget {
  @override
  _SalesDrawerHeaderState createState() => _SalesDrawerHeaderState();
}

class _SalesDrawerHeaderState extends State<SalesDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
      padding: EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0), // Add padding to the left
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left)
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                ),
                Text(
                  "Vhenus Tumbaga",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "vt@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

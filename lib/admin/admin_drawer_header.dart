import 'package:flutter/material.dart';

import '/services/user_all.dart';

class AdminDrawerHeader extends StatefulWidget {
  final User_all userAll;

  const AdminDrawerHeader({Key? key, required this.userAll}) : super(key: key);

  @override
  _AdminDrawerHeaderState createState() => _AdminDrawerHeaderState();
}

class _AdminDrawerHeaderState extends State<AdminDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
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
                      image: AssetImage(_getProfileImage()),
                    ),
                  ),
                ),
                Text(
                  widget.userAll.username ?? 'Guest', // Provide a default value
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.userAll.email ?? 'No email', // Provide a default value
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

  String _getProfileImage() {
    if (widget.userAll.gender == 'male') {
      return 'assets/images/male.png'; // Image for male users
    } else if (widget.userAll.gender == 'female') {
      return 'assets/images/female.png'; // Image for female users
    } else {
      return 'assets/images/profile.jpg'; // Default image
    }
  }
}

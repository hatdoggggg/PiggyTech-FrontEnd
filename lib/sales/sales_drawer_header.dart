import 'package:flutter/material.dart';
import '/services/user_all.dart';

class SalesDrawerHeader extends StatefulWidget {
  final User_all userAll;

  const SalesDrawerHeader({Key? key, required this.userAll}) : super(key: key);

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
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(_getProfileImage()),
                      fit: BoxFit.cover, // Ensure the image fits within the circle
                    ),
                  ),
                ),
                Text(
                  capitalizeFirstLetter(widget.userAll.username ?? 'Username not available'), // Capitalize first letter
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.userAll.email ?? 'Email not available', // Handle null email
                  style: const TextStyle(
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

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}

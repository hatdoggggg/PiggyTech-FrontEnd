import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/../admin/admin_drawer_list.dart';
import '/../services/user_all.dart'; // Update the import to point to your user model

class SelectedUsers extends StatelessWidget {
  final User_all user_all;

  const SelectedUsers({super.key, required this.user_all});

  @override
  Widget build(BuildContext context) {
    // Determine the image to display based on gender
    String imagePath = user_all.gender == 'male'
        ? 'assets/images/male.png'
        : 'assets/images/female.png';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDrawerList(initialPage: DrawerSections.users),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the gender image
            Center(
              child: Image.asset(
                imagePath,
                width: 100.0,
                height: 100.0,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  'Name:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Text(
                  user_all.username,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Text(
                  user_all.email,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Address:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Text(
                  user_all.address,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Phone:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Text(
                  user_all.phone,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Gender:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Text(
                  user_all.gender,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Created At:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Text(
                  DateFormat('yyyy-MM-dd').format(user_all.createdAt),
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

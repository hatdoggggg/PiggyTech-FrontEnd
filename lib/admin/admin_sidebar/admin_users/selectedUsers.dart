import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/services/user_all.dart'; // Update the import to point to your user model

class SelectedUsers extends StatelessWidget {
  final User_all user_all;

  const SelectedUsers({super.key, required this.user_all});

  @override
  Widget build(BuildContext context) {
    // Determine the image to display based on gender
    String imagePath = user_all.gender?.toLowerCase() == 'male'
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
            Navigator.pop(context); // Use pop to go back to previous screen
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
            _buildUserInfoRow('Name:', user_all.username ?? 'N/A'),
            SizedBox(height: 10.0),
            _buildUserInfoRow('Email:', user_all.email ?? 'N/A'),
            SizedBox(height: 10.0),
            _buildUserInfoRow('Address:', user_all.address ?? 'N/A'),
            SizedBox(height: 10.0),
            _buildUserInfoRow('Phone:', user_all.phone ?? 'N/A'),
            SizedBox(height: 10.0),
            _buildUserInfoRow('Gender:', user_all.gender ?? 'N/A'),
            SizedBox(height: 10.0),
            _buildUserInfoRow(
              'Created At:',
              DateFormat('yyyy-MM-dd').format(user_all.createdAt ?? DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 20.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
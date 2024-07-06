import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.png'),
                    radius: 50.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit profile image',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.person, 'Name', 'Vhenus Tumbaga'),
            buildProfileItem(Icons.location_city, 'Address', 'Calaca City'),
            buildProfileItem(Icons.phone, 'Phone No', '0123456789'),
            buildProfileItem(Icons.email, 'Email', 'vt@gmail.com'),
            buildProfileItem(Icons.lock, 'Password', 'password123'),
            buildProfileItem(Icons.date_range, 'Created On', '2024-01-01'),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 10.0),
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
    );
  }
}
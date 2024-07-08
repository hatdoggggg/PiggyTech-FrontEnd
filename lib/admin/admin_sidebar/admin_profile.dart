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
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                    radius: 50.0,
                  ),
                  TextButton(
                    child: const Text(
                      'Edit profile image',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      print('Photo');
                    },
                  ),
                ],
              ),
            ),
            Divider(
              height: 20.0,
              color: Colors.black,
              thickness: 2.0,
            ),
            Text(
              'Profile Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            buildProfileItem(Icons.person, 'Name', 'Vhenus Tumbaga', () {
              // Add your onPressed functionality here
              print('Edit Name pressed');
            }),
            Divider(
              height: 20.0,
              color: Colors.black,
              thickness: 2.0,
            ),
            Text(
              'Personal Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            buildProfileItem(Icons.location_city, 'Address', 'Calaca City', () {
              // Add your onPressed functionality here
              print('Edit Address pressed');
            }),
            buildProfileItem(Icons.phone, 'Phone No', '0123456789', () {
              // Add your onPressed functionality here
              print('Edit Phone No pressed');
            }),
            buildProfileItem(Icons.email, 'Email', 'vt@gmail.com', () {
              // Add your onPressed functionality here
              print('Edit Email pressed');
            }),
            buildProfileItem(Icons.lock, 'Password', 'password123', () {
              // Add your onPressed functionality here
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SalesDashboardPage()),);
              print('Edit Password pressed');
            }),
            buildProfileItem(Icons.date_range, 'Created On', '2024-01-01', () {
              // Add your onPressed functionality here
              print('Edit Created On pressed');
            }),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String title, String value, VoidCallback onPressed) {
    return Row(
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
        const SizedBox(width: 5.0),
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SalesProfilePage extends StatefulWidget {
  const SalesProfilePage({Key? key}) : super(key: key);

  @override
  _SalesProfilePageState createState() => _SalesProfilePageState();
}

class _SalesProfilePageState extends State<SalesProfilePage> {
  String name = 'Vhenus Tumbaga';
  String address = 'Calaca City';
  String phoneNumber = '0123456789';
  String email = 'vt@gmail.com';
  String password = 'password123';
  String createdOn = '2024-01-01';

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
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    radius: 50.0,
                  ),
                  TextButton(
                    onPressed: () {
                      _showEditProfileModal(context);
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
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
            const SizedBox(height: 15.0),
            buildProfileItem(Icons.person, 'Name', name),
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
            const SizedBox(height: 15.0),
            buildProfileItem(Icons.location_city, 'Address', address),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.phone, 'Phone No', phoneNumber),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.email, 'Email', email),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.lock, 'Password', password),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.date_range, 'Created On', createdOn),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String title, String value) {
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
      ],
    );
  }

  void _showEditProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildEditField('Name', name, (String newName) {
                setState(() {
                  name = newName;
                });
              }),
              _buildEditField('Address', address, (String newAddress) {
                setState(() {
                  address = newAddress;
                });
              }),
              _buildEditField('Phone Number', phoneNumber, (String newPhoneNumber) {
                setState(() {
                  phoneNumber = newPhoneNumber;
                });
              }),
              _buildEditField('Email', email, (String newEmail) {
                setState(() {
                  email = newEmail;
                });
              }),
              _buildEditField('Password', password, (String newPassword) {
                setState(() {
                  password = newPassword;
                });
              }),
              _buildEditField('Created On', createdOn, (String newCreatedOn) {
                setState(() {
                  createdOn = newCreatedOn;
                });
              }),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal bottom sheet
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditField(String title, String initialValue, Function(String) onChanged) {
    TextEditingController controller = TextEditingController(text: initialValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

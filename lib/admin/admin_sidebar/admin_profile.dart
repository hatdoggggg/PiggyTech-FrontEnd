import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

import '/services/user_all.dart';

class AdminProfilePage extends StatefulWidget {
  final User_all user_all;

  const AdminProfilePage({Key? key, required this.user_all}) : super(key: key);

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  late User_all user_all;
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _createdAtController;

  @override
  void initState() {
    super.initState();
    user_all = widget.user_all;

    _nameController = TextEditingController(text: user_all.username ?? '');
    _addressController = TextEditingController(text: user_all.address ?? '');
    _phoneController = TextEditingController(text: user_all.phone ?? '');
    _genderController = TextEditingController(text: user_all.gender ?? '');
    _emailController = TextEditingController(text: user_all.email ?? '');
    _passwordController = TextEditingController(text: user_all.password ?? '');
    _createdAtController = TextEditingController(
      text: user_all.createdAt != null ? DateFormat('yyyy-MM-dd').format(user_all.createdAt!) : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _createdAtController.dispose();
    super.dispose();
  }

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
                  CircleAvatar(
                    backgroundImage: AssetImage(_getProfileImage()),
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
            buildProfileItem(Icons.person, 'Name:', user_all.username ?? ''),
            const SizedBox(height: 10.0),
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
            buildProfileItem(Icons.location_city, 'Address:', user_all.address ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.phone, 'Phone No:', user_all.phone ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.male, 'Gender:', user_all.gender ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.email, 'Email:', user_all.email ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.lock, 'Password:', '••••••••'), // Masked password
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.date_range, 'Created At:', user_all.createdAt != null ? DateFormat('yyyy-MM-dd').format(user_all.createdAt!) : ''),
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
              _buildEditField('Name', _nameController),
              _buildEditField('Address', _addressController),
              _buildEditField('Phone Number', _phoneController),
              _buildEditField('Gender', _genderController),
              _buildEditField('Email', _emailController),
              _buildEditField('Password', _passwordController, obscureText: true), // Mask password input
              _buildEditField('Created On', _createdAtController),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      setState(() {
                        user_all.username = _nameController.text;
                        user_all.address = _addressController.text;
                        user_all.phone = _phoneController.text;
                        user_all.email = _emailController.text;
                        user_all.password = _passwordController.text;
                        user_all.createdAt = DateTime.tryParse(_createdAtController.text) ?? DateTime.now(); // Parse the date
                      });
                      Navigator.pop(context);
                    }
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

  Widget _buildEditField(String title, TextEditingController controller, {bool obscureText = false}) {
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
          obscureText: obscureText, // Mask text if it's a password
          keyboardType: title == 'Created On' ? TextInputType.datetime : TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  bool _validateInputs() {
    // Add your validation logic here
    // Return true if inputs are valid, false otherwise
    return true;
  }

  String _getProfileImage() {
    if (user_all.gender == 'Male') {
      return 'assets/images/profile_male.png'; // Image for male users
    } else if (user_all.gender == 'Female') {
      return 'assets/images/profile_female.png'; // Image for female users
    } else {
      return 'assets/images/profile_default.jpg'; // Default image
    }
  }
}

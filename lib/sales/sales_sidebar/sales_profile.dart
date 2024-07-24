import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/services/user_all.dart';

class SalesProfilePage extends StatefulWidget {
  final User_all userAll;

  const SalesProfilePage({Key? key, required this.userAll}) : super(key: key);

  @override
  _SalesProfilePageState createState() => _SalesProfilePageState();
}

class _SalesProfilePageState extends State<SalesProfilePage> {
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

    _nameController = TextEditingController(text: widget.userAll.username ?? '');
    _addressController = TextEditingController(text: widget.userAll.address ?? '');
    _phoneController = TextEditingController(text: widget.userAll.phone ?? '');
    _genderController = TextEditingController(text: widget.userAll.gender ?? '');
    _emailController = TextEditingController(text: widget.userAll.email ?? '');
    _passwordController = TextEditingController(text: widget.userAll.password ?? '');
    _createdAtController = TextEditingController(
      text: widget.userAll.createdAt != null ? DateFormat('yyyy-MM-dd').format(widget.userAll.createdAt!) : '',
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
            buildProfileItem(Icons.person, 'Name:', widget.userAll.username ?? ''),
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
            buildProfileItem(Icons.location_city, 'Address:', widget.userAll.address ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.phone, 'Phone No:', widget.userAll.phone ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.male, 'Gender:', widget.userAll.gender ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.email, 'Email:', widget.userAll.email ?? ''),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.lock, 'Password:', '••••••••'),
            const SizedBox(height: 20.0),
            buildProfileItem(Icons.date_range, 'Created On:', widget.userAll.createdAt != null ? DateFormat('yyyy-MM-dd').format(widget.userAll.createdAt!) : ''),
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
              _buildEditField('Name', _nameController),
              _buildEditField('Address', _addressController),
              _buildEditField('Phone Number', _phoneController),
              _buildEditField('Gender', _genderController),
              _buildEditField('Email', _emailController),
              _buildEditField('Password', _passwordController, obscureText: true),
              _buildEditField('Created On', _createdAtController),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      setState(() {
                        widget.userAll.username = _nameController.text;
                        widget.userAll.address = _addressController.text;
                        widget.userAll.phone = _phoneController.text;
                        widget.userAll.gender = _genderController.text;
                        widget.userAll.email = _emailController.text;
                        widget.userAll.password = _passwordController.text;
                        widget.userAll.createdAt = DateTime.tryParse(
                            _createdAtController.text) ?? DateTime.now();
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
          obscureText: obscureText,
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
    return true;
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

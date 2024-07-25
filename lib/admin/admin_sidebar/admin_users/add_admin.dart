import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../admin_drawer_list.dart';
import '/services/user_all.dart';
import '/services/userdetail.dart';
import '/services/user.dart';

class AddAdmin extends StatefulWidget {
  final User_all userAll;

  const AddAdmin({super.key, required this.userAll});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  String gender = '';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;

  Future<bool> createAccount(User user) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'username': user.username,
        'email': user.email,
        'password': user.password,
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> accountDetail(UserDetail userDetail) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/userdetail/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'email' : userDetail.email,
        'phone' : userDetail.phone,
        'address' : userDetail.address,
        'gender' : userDetail.gender
      }),
    );
    return response.statusCode == 200;
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully Added'),
          content: Text('New admin account is added.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDrawerList(
                      initialPage: DrawerSections.users,
                      userAll: widget.userAll,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed to add admin'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Add Admin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                'Insert all information.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                maxLength: 40,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a name';
                  }
                  if (value.length < 2) {
                    return 'Name should be at least 2 letters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  username = value!;
                },
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an email';
                  }
                  if (!value.contains('@')) {
                    return 'Email should contain an @ symbol';
                  }
                  if (!value.endsWith('.com')) {
                    return 'Email should end with .com';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                obscureText: _obscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureIcon),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                        if (_obscure) {
                          _obscureIcon = Icons.visibility_off;
                        } else {
                          _obscureIcon = Icons.visibility;
                        }
                      });
                    },
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a password';
                  }
                  if (value.length < 8) {
                    return 'Password should be at least 8 letters long';
                  }
                  if (value.length > 20) {
                    return 'Password must be 20 characters long only';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                maxLength: 11,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a phone number';
                  }
                  if (value.length < 11) {
                    return 'Phone number should be at least 11 numbers';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = value!;
                },
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value!;
                },
              ),
              SizedBox(height: 15.0,),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InputDecorator(
                        decoration: InputDecoration(
                          hintText: 'Gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          filled: true,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.male),
                                SizedBox(width: 10),
                                Text(
                                  'Select Gender:',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio<String>(
                                      value: 'male',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value!;
                                          state.didChange(value);
                                        });
                                      },
                                    ),
                                    Text('Male'),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Row(
                                  children: <Widget>[
                                    Radio<String>(
                                      value: 'female',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value!;
                                          state.didChange(value);
                                        });
                                      },
                                    ),
                                    Text('Female'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          ),
                        ),
                    ],
                  );
                },
                validator: (value) {
                  if (gender.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        final user = User(
                          username: username,
                          email: email,
                          password: password,
                        );

                        final userDetail = UserDetail(
                          email: email,
                          phone: phone,
                          address: address,
                          gender: gender,
                        );

                        bool accountCreated = await createAccount(user);
                        if (accountCreated) {
                          bool detailsSaved = await accountDetail(userDetail);
                          if (detailsSaved) {
                            showSuccessDialog();
                          } else {
                            showErrorDialog('Failed to save user details');
                          }
                        } else {
                          showErrorDialog('Failed to create account');
                        }
                      }
                    },
                    child: Text('Add'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
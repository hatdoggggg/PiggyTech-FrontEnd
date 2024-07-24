import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'services/userdetail.dart';
import 'login_screen.dart';

class UserDetailScreen extends StatefulWidget {
  final String email;

  UserDetailScreen({required this.email});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String phoneNumber = '';
  String address = '';
  String gender = '';

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
          title: Text('Signup Successful'),
          content: Text('You have successfully completed the signup process. You can now login.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
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
          title: Text('Signup Failed'),
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
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 50.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 130.0),
              Text(
                'Fill in your Information!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  fontSize: 24.5,
                ),
              ),
              SizedBox(height: 30.0),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 11,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
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
                        phoneNumber = value!;
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Address',
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
                    SizedBox(height: 30.0),
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
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              UserDetail userDetail = UserDetail(
                                  email: widget.email,
                                  phone: phoneNumber,
                                  address: address,
                                  gender: gender
                              );
                              bool success = await accountDetail(userDetail);
                              if(success){
                                showSuccessDialog();
                              } else {
                                showErrorDialog('Please try again.');
                              }
                            }
                          },
                          child: Text('Okay'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
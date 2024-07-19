import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Define GlobalKey

  String phoneNumber = '';
  String address = '';
  String gender = ''; // To store selected gender
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 50.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 130.0),
              Text(
                'Let\'s Get Started!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  fontSize: 24.5,
                ),
              ),
              SizedBox(height: 30.0),
              Form(
                key: formKey, // Use widget.formKey here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 11,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a phone number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide an address';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    SizedBox(height: 30.0),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: Icon(Icons.male),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          isEmpty: gender == '',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio<String>(
                                value: 'male',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                              Text('Male'),
                              SizedBox(width: 20),
                              Radio<String>(
                                value: 'female',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                              Text('Female'),
                            ],
                          ),
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Proceed with form submission
                          print('Phone Number: $phoneNumber');
                          print('Address: $address');
                          print('Gender: $gender');
                        }
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          child: Text(
                            'Log in here',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
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

void main() {
  runApp(MaterialApp(
    home: Signup(),
  ));
}

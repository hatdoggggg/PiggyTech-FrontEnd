import 'package:flutter/material.dart';
import 'login_screen.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String phoneNumber = '';
  String address = '';
  String gender = '';

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
                'Fill your Information!',
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
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

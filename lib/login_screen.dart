import 'package:flutter/material.dart';

import 'admin/admin_drawer_list.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _login(bool isLogin) {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for the login process
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      if (isLogin) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDrawerList()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  _header(context),
                  Spacer(flex: 1),
                  _inputField(context),
                  Spacer(flex: 3),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
        Text(
          "Welcome to PiggyTech",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          obscureText: !_isPasswordVisible,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print("Email: ${_emailController.text}");
                print("Password: ${_passwordController.text}");
                _login(true); // Login to Admin
              },
              child: Text(
                "Login to Admin",
                style: TextStyle(fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                print("Email: ${_emailController.text}");
                print("Password: ${_passwordController.text}");
                _login(false); // Login to Cashier
              },
              child: Text(
                "Login to Cashier",
                style: TextStyle(fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

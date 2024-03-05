
import 'package:assignmentapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login & Signup Demo'),
      ),
      body: Center(
        child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    ),
    SizedBox(height: 10),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    ),
    SizedBox(height: 20),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          final authprovider = AuthProvider();
          authprovider.login(
            context,
            _emailController.text,
            _passwordController.text,
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, 
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40), // button padding
        ),
        child: Text('Login'),
      ),
    ),
    SizedBox(height: 10),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          final authprovider = AuthProvider();
          authprovider.signUp(
            context,
            _emailController.text,
            _passwordController.text,
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // background color
          onPrimary: Colors.white, // text color
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40), // button padding
        ),
        child: Text('Sign Up'),
      ),
    ),
  ],
),

   ),
    );
  }
}

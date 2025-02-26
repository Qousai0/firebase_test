import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pr1/screens/home.dart' show Homeee, homeee;
import 'package:pr1/screens/screen1.dart' show SignUpPage;

class Signin extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Signin> {
  // Create text controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle sign-up logic
  void _handleSignin() async {
    try{
    final ouruser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    print(ouruser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homeee()),
      );
  }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 2),
      ),
    );}
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
             GestureDetector(
          onTap: () {
          Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
            print('تم الضغط على النص!');
          },
          child: Text("Forget password ? CLICK HERE")),
            ElevatedButton(
              onPressed: () {
                _handleSignin();
              },
              child: Text('sigen in'),
            ),
          ],
        ),
      ),
    );
  }
}

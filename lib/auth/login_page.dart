// Form	Fields / Requirements
// Login	Email/Phone, Password, Forgot Password


import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Your Account"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade100
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                
                labelText: "Username",
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
             SizedBox(height: 10),
             TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                
                labelText: "Email",
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
             TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
             SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

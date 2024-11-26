import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = "teacher"; // Default role
  String _statusMessage = "";

  // Function to create a new user by making a POST request to the API
  Future<void> _createUser() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _statusMessage = "Email and password cannot be empty!";
      });
      return;
    }

    const String apiUrl = 'http://localhost:5000/create_user'; // API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email,
          'password': password,
          'role': _role, // Either 'teacher' or 'parent'
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = "User created successfully!";
        });
      } else {
        setState(() {
          _statusMessage = "Failed to create user: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Error connecting to API: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true, // Mask the password input
            ),
            SizedBox(height: 16.0),
            Text("Select Role:"),
            Row(
              children: [
                Radio(
                  value: "teacher",
                  groupValue: _role,
                  onChanged: (value) {
                    setState(() {
                      _role = value.toString();
                    });
                  },
                ),
                Text("Teacher"),
                Radio(
                  value: "parent",
                  groupValue: _role,
                  onChanged: (value) {
                    setState(() {
                      _role = value.toString();
                    });
                  },
                ),
                Text("Parent"),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _createUser,
                child: Text("Create User"),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                _statusMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart'; // your home screen after login/signup
import 'package:flutter/material.dart';
import 'login.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 60),
              Text(
                "Create your account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 10),
              Text("Register to get started", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),
              TextFormField(
                controller: _firstNameController,
                decoration: _inputDecoration("First Name"),
                validator: (value) => value!.isEmpty ? 'First name is required' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _lastNameController,
                decoration: _inputDecoration("Last Name"),
                validator: (value) => value!.isEmpty ? 'Last name is required' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration("Email"),
                validator: (value) => value!.isEmpty ? 'Email is required' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                decoration: _inputDecoration("Password"),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Password is required' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Age (Optional)"),
              ),
              SizedBox(height: 15),
              Text("Gender (Optional)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Male"),
                      value: "Male",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Female"),
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Other"),
                      value: "Other",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Registration successful!")),
                      );

                      // Navigate to Home
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.message}")),
                      );
                    }
                  }
                },

               
                child: Text("Sign Up"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }
}

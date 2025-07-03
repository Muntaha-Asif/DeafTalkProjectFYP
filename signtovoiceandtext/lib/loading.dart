import 'package:flutter/material.dart';
import 'login.dart';
import 'registeration.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView( // Added to prevent overflow
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures it doesn't exceed available space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.language,
                  size: 80,
                  color: Colors.green,
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Sign Speak",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                    },
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

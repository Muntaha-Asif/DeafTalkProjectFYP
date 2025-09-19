import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo or Icon
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.shade100,
                child: const Icon(
                  Icons.sign_language,
                  size: 60,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App Description
            const Text(
              "📱 About DeafTalk",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "DeafTalk is a mobile application designed to facilitate two-way "
              "communication between deaf/mute individuals and non-sign language users. "
              "It uses gesture recognition, speech processing, and video-based sign "
              "language to create a seamless communication bridge.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            const Divider(height: 30, thickness: 1),

            // How it helps
            const Text(
              "🌍 How This App Helps",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "✔ Makes communication easier between deaf/mute individuals and others.\n"
              "✔ Reduces dependency on human interpreters.\n"
              "✔ Helps in daily conversations such as greetings, asking questions, and expressing needs.\n"
              "✔ Encourages inclusivity in education, workplaces, and social interactions.",
              style: TextStyle(fontSize: 16),
            ),

            const Divider(height: 30, thickness: 1),

            // How to use
            const Text(
              "📖 How to Use DeafTalk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "1️⃣ Open the app and choose a module:\n"
              "   - Gestures ➝ Text/Voice\n"
              "   - Text/Voice ➝ Gestures\n\n"
              "2️⃣ If you are a deaf/mute user, show a hand gesture to the camera, "
              "and the app will translate it into text or voice.\n\n"
              "3️⃣ If you are a non-sign language user, speak or type a sentence, "
              "and the app will display a corresponding sign language video.\n\n"
              "4️⃣ Continue the conversation smoothly without barriers.",
              style: TextStyle(fontSize: 16),
            ),

            const Divider(height: 30, thickness: 1),

            // Why needed
            const Text(
              "❓ Why This App is Needed",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Millions of deaf and mute individuals face challenges in everyday communication "
              "because many people do not understand sign language. Existing solutions often require "
              "human interpreters, which are not always available. DeafTalk solves this problem by "
              "providing a digital communication bridge that works anytime, anywhere.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            const Divider(height: 30, thickness: 1),

            // University Information
            const Text(
              "🏫 University Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("University: National University of Modern Languages (NUML)"),
            const Text("Department: Computer Science"),

            const Divider(height: 30, thickness: 1),

            // Supervisor
            const Text(
              "👨‍🏫 Supervisor",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Name: Miss Makia Nazir"),
            const Text("Designation: Lecturer"),

            const Divider(height: 30, thickness: 1),

            // Team Members
            const Text(
              "👩‍💻 Team Members",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("1. Muntaha Asif"),
            const Text("2. Faiza Aziz"),
            const Text("3. Muqadas Javed"),

            const Divider(height: 30, thickness: 1),

            // Contact
            const Text(
              "📧 Contact",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Email: team@example.com"),
            const Text("Version: 1.0.0"),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

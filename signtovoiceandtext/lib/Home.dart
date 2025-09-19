import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'gestures_to_voice_and_text.dart';
import 'Voice_To_Gestures_And_Text.dart';
import 'localization_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'about_page.dart';
import 'login.dart'; // Import LoginPage for redirection after logout

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(480),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(bottom: BorderSide(color: Colors.green, width: 4)),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("welcome".tr, style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.green, size: 30),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 70,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Center(
                  child: Text(
                    "menu".tr,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.green),
              title: Text("change_language".tr, style: TextStyle(color: Colors.green)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("select_language".tr),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("English"),
                          onTap: () {
                            LocalizationService.changeLocale('en');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("اردو"),
                          onTap: () {
                            LocalizationService.changeLocale('ur');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text("About".tr, style: TextStyle(color: Colors.green)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },

            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.green),
              title: Text("Logout".tr, style: TextStyle(color: Colors.green)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildNavigationButton(
              context,
              title: "sign_to_text".tr,
              subtitle: "sign_to_text_desc".tr,
              icon: Icons.text_format,
              color: Colors.green,
              destination: SignToVoicePage(),
            ),
            SizedBox(height: 15),
            _buildNavigationButton(
              context,
              title: "text_to_sign".tr,
              subtitle: "text_to_sign_desc".tr,
              icon: Icons.record_voice_over,
              color: Colors.green,
              destination: SpeechToGestureScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Color color,
      required Widget destination}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(subtitle, style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

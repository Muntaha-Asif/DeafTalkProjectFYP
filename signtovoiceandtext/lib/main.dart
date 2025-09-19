import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:signtovoiceandtext/translation_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'translation.dart';
import 'home.dart';
import 'loading.dart';
void main()async {
  
 
   WidgetsFlutterBinding.ensureInitialized();
  WebViewPlatform.instance = WebKitWebViewPlatform();
  // ✅ Initialize Hive storage before use
   Hive.initFlutter();
   Hive.openBox('translations'); // Ensure translations box is open
   TranslationService.initializeStorage();
   AppTranslations.initialize(); // ✅ Load stored translations asynchronously
if(kIsWeb) {
    // ✅ Initialize Firebase for web
   await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDxYKGsDndlv8bZ7t3uFNt4RB2Myq1OXiw",
        authDomain: "deaftalk-99440.firebaseapp.com",
        appId: "1:939044280574:web:93b3e2e80c2dc4da8b2daf",
        messagingSenderId: "939044280574",
        projectId: "deaftalk-99440",
        storageBucket: "deaftalk-99440.appspot.com",
        measurementId: "G-RBMQ8PEMDX"
      )
    );
  } else {
    // ✅ Initialize Firebase for mobile platforms
   await Firebase.initializeApp();
  }   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      locale: Get.deviceLocale, // Auto-detect device locale
      fallbackLocale: Locale('en', 'US'), // Fallback if locale is missing
      translations: AppTranslations(), // ✅ Register translations
       home: HomePage(),
      // home: LoadingPage(),
    );
  }
}

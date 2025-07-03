import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToGestureScreen extends StatefulWidget {
  const SpeechToGestureScreen({super.key});

  @override
  SpeechToGestureScreenState createState() => SpeechToGestureScreenState();
}

class SpeechToGestureScreenState extends State<SpeechToGestureScreen> {
  final String _avatarGesture = "idle"; // Default pose
  final stt.SpeechToText _speechToText = stt.SpeechToText(); // Speech recognition instance
  final _recognizedText = "".obs; // Observed variable for recognized text
  bool isListening = false; // To track whether the mic is active

  // Track the current language for speech recognition
  String currentLocale = "en_US"; // Default to English

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // Initialize speech recognition
  Future<void> _initSpeech() async {
    bool available = await _speechToText.initialize();
    if (!available) {
      _recognizedText.value = "Speech recognition not available.";
    }
  }

  // Start or stop listening based on the current state
  void _toggleListening() async {
    if (isListening) {
      await _speechToText.stop(); // Stop listening
      setState(() {
        isListening = false; // Update state to show mic as inactive
      });
    } else {
      await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _recognizedText.value = result.recognizedWords; // Update text
            // Dynamically change language based on input
            if (isEnglish(result.recognizedWords)) {
              currentLocale = "en_US"; // Switch to English locale
            } else {
              currentLocale = "ur_PK"; // Switch to Urdu locale
            }
          });
        },
        localeId: currentLocale, // Use the dynamic locale for speech recognition
      );
      setState(() {
        isListening = true; // Update state to show mic as active
      });
    }
  }

  // Check if the recognized words are in English (simple check for now)
  bool isEnglish(String text) {
    // You can improve this with a more robust language detection logic
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "speech_to_gesture_avatar".tr, // No Obx() needed, GetX automatically translates
          style: TextStyle(color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ModelViewer(
              src: "assets/avatar.glb",
              ar: true,
              disableZoom: true,
              autoRotate: false,
              backgroundColor: Colors.white,
              animationName: _avatarGesture,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "was_this_sign_easy_to_learn".tr, // No Obx() needed
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.thumb_up, color: Colors.white),
                  SizedBox(width: 6),
                  Icon(Icons.thumb_down, color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Row for mic button and recognized text with reversed order
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out mic and text
              children: [
                // Use an Expanded widget to prevent overflow
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Text(
                      _recognizedText.value.isEmpty ? "Say something...".tr : _recognizedText.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Noto Nastaliq Urdu', // Ensure proper Urdu font rendering
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Space between the mic and the text box
                FloatingActionButton(
                  onPressed: _toggleListening, // Toggle listening state
                  backgroundColor: Colors.green,
                  child: Icon(
                    isListening ? Icons.stop : Icons.mic, // Change icon based on listening state
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class SignToVoicePage extends StatefulWidget {
  const SignToVoicePage({super.key});

  @override
  _SignToVoicePageState createState() => _SignToVoicePageState();
}

class _SignToVoicePageState extends State<SignToVoicePage> {
  CameraController? _cameraController;
  final FlutterTts _flutterTts = FlutterTts();
  String recognizedText = "waiting_for_sign".tr;
  late Future<void> _cameraFuture;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _cameraFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception("no_cameras_found".tr);
      }
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );
      await _cameraController?.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("${"error_initializing_camera".tr}: $e");
    }
  }

  void _speakText() async {
    await _flutterTts.speak(recognizedText);
  }

  void _startProcessing() {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
      recognizedText = "processing_signs".tr;
    });

    _processSignLanguage();
  }

  void _processSignLanguage() async {
    while (_isProcessing) {
      await Future.delayed(Duration(seconds: 2)); // Simulate real-time processing

      setState(() {
        recognizedText = "${"recognized_sign".tr} ${"hello".tr}";
      });

    }
  }

  void _stopProcessing() {
    setState(() {
      _isProcessing = false;
      recognizedText = "waiting_for_sign".tr;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Colors.green,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "sign_to_text_and_voice".tr,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: FutureBuilder<void>(
              future: _cameraFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _cameraController != null && _cameraController!.value.isInitialized
                      ? Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green, width: 5),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CameraPreview(_cameraController!),
                  )
                      : Center(child: Text("failed_to_load_camera".tr, style: TextStyle(color: Colors.black)));
                } else {
                  return Center(child: CircularProgressIndicator(color: Colors.green));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              recognizedText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: _isProcessing ? _stopProcessing : _startProcessing,
            child: Text(_isProcessing ? "stop_recording".tr : "start_recording".tr),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: _speakText,
            child: Text("play_voice_output".tr),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
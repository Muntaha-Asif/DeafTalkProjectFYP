import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:video_player/video_player.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:string_similarity/string_similarity.dart';

class SpeechToGestureScreen extends StatefulWidget {
  const SpeechToGestureScreen({super.key});

  @override
  SpeechToGestureScreenState createState() => SpeechToGestureScreenState();
}

class SpeechToGestureScreenState extends State<SpeechToGestureScreen> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final TextEditingController _textController = TextEditingController();
  final _recognizedText = "".obs;
  bool isListening = false;
  String currentLocale = "en_US";
  VideoPlayerController? _controller;
  bool _isVideoReady = false;

  final Map<String, String> gestureVideos = {
    "fine": "assets/videos/fine.mp4",
    "food": "assets/videos/food.mp4",
    "good": "assets/videos/good.mp4",
    "hello": "assets/videos/hello1.mp4",
    "how can i help you": "assets/videos/howcanIhelpu.mp4",
    "how do you feel": "assets/videos/howdoUfeel.mp4",
    "how are you": "assets/videos/HowRU1.mp4",
    "i do not believe this": "assets/videos/Idontbelievethis.mp4",
    "i": "assets/videos/I.mp4",
    "i do not like this": "assets/videos/Idontlikethis.mp4",
    "i do not understand": "assets/videos/Idontunderstand.mp4",
    "i am learning sign language": "assets/videos/IMlearningSignlang.mp4",
    "i am sick": "assets/videos/IMsick.mp4",
    "i am a student": "assets/videos/IMstudent.mp4",
    "no": "assets/videos/no.mp4",
    "are you deaf": "assets/videos/RUdeaf.mp4",
    "are you hungry": "assets/videos/RUhungry.mp4",
    "thanks": "assets/videos/Thanks.mp4",
    "want": "assets/videos/want.mp4",
    "water": "assets/videos/water.mp4",
    "what": "assets/videos/what.mp4",
    "what is your name": "assets/videos/WhatURName.mp4",
    "when": "assets/videos/when.mp4",
    "who": "assets/videos/who.mp4",
    "why": "assets/videos/why.mp4",
    "yes": "assets/videos/yes.mp4",
    "you": "assets/videos/you.mp4",
    "come": "assets/videos/come.mp4",
    "morning": "assets/videos/morning.mp4",
    "after": "assets/videos/after.mp4",
    "evening": "assets/videos/evening.mp4",
    "again": "assets/videos/again.mp4",
    "she": "assets/videos/she.mp4",
    "he": "assets/videos/he.mp4",
    "all": "assets/videos/all.mp4",
    "outside": "assets/videos/outside.mp4",
    "inside": "assets/videos/inside.mp4",
    "it is fine": "assets/videos/itsFine.mp4",
    "i will be back soon": "assets/videos/illBeBacksoon.mp4",
    "always": "assets/videos/always.mp4",
    "cute": "assets/videos/cute.mp4",
    "beautiful": "assets/videos/beautiful.mp4",
    "ok": "assets/videos/ok.mp4",
    "so": "assets/videos/so.mp4",
    "sister": "assets/videos/sister.mp4",
    "brother": "assets/videos/brother.mp4",
    "we": "assets/videos/we.mp4",
    "same": "assets/videos/same.mp4",

  };

  List<String> _videoQueue = [];
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

String? findClosestMatch(String input, Map<String, String> gestureVideos) {
  List<String> phrases = gestureVideos.keys.toList();
  var bestMatch = StringSimilarity.findBestMatch(input, phrases);

  // ✅ Null-safety fix
  double? rating = bestMatch.bestMatch.rating;
  if (rating != null && rating >= 0.6) {
    print("🔄 Corrected '$input' → '${bestMatch.bestMatch.target}'");
    return bestMatch.bestMatch.target;
  }

  return null; // no close match found
}


  Future<void> _initSpeech() async {
    bool available = await _speechToText.initialize();
    if (!available) {
      _recognizedText.value = "Speech recognition not available.";
    }
  }

  void _toggleListening() async {
    if (isListening) {
      await _speechToText.stop();
      setState(() => isListening = false);
    } else {
      await _speechToText.listen(
        onResult: (result) => _playVideoFromWords(result.recognizedWords),
        localeId: currentLocale,
      );
      setState(() => isListening = true);
    }
  }

  Future<void> _playVideoFromWords(String sentence) async {
    _recognizedText.value = sentence;
    _controller?.dispose();

    // Step 1: Translate Urdu to English
    try {
      sentence = await translateToEnglish(sentence);
      print('✅ Translated sentence: $sentence');
    } catch (e) {
      print('❌ Translation error: $e');
      _recognizedText.value = "Translation error.";
      return;
    }

    // Step 2: Normalize
    String normalized = normalizeText(sentence);
    print('🔹 Normalized sentence: $normalized');

    List<String> words = normalized.split(" ");
    _videoQueue = [];

    // Step 3: Match longest phrases first
    int i = 0;
    while (i < words.length) {
      bool matched = false;
      for (int len = 5; len >= 1; len--) {
  if (i + len <= words.length) {
    String phrase = words.sublist(i, i + len).join(" ");

    // Exact match
    if (gestureVideos.containsKey(phrase)) {
      print('🎯 Matched phrase: "$phrase"');
      _videoQueue.add(gestureVideos[phrase]!);
      i += len;
      matched = true;
      break;
    } else {
      // Fuzzy match
      String? corrected = findClosestMatch(phrase, gestureVideos);
      if (corrected != null) {
        print('✨ Auto-corrected "$phrase" → "$corrected"');
        _videoQueue.add(gestureVideos[corrected]!);
        i += len;
        matched = true;
        break;
      }
    }
  }
}

      if (!matched) {
        print('⚠️ No match for word: "${words[i]}"');
        i++;
      }
    }

    // Step 4: Play videos in queue
    if (_videoQueue.isNotEmpty) {
      _currentVideoIndex = 0;
      await _playNextVideo();
    } else {
      print("❌ No videos found for this sentence.");
      setState(() => _isVideoReady = false);
    }
  }

  Future<void> _playNextVideo() async {
    if (_currentVideoIndex >= _videoQueue.length) {
      setState(() => _isVideoReady = false);
      return;
    }

    String nextVideo = _videoQueue[_currentVideoIndex];
    print('▶ Playing video: $nextVideo');

    _controller?.dispose();
    _controller = VideoPlayerController.asset(nextVideo);

    await _controller!.initialize();
    setState(() => _isVideoReady = true);
    _controller!.play();

    _controller!.addListener(() {
      if (_controller != null &&
          _controller!.value.position >= _controller!.value.duration &&
          !_controller!.value.isPlaying) {
        _controller!.removeListener(() {});
        _currentVideoIndex++;
        _playNextVideo();
      }
    });
  }

  Future<String> translateToEnglish(String text) async {
    if (text.trim().isEmpty) return text;

    print('🌍 Original input: $text');

    try {
      final response = await http.post(
        Uri.parse('https://translate.astian.org/translate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'source': 'ur',
          'target': 'en',
          'format': 'text',
        }),
      );

      print('🌍 Translation API status: ${response.statusCode}');
      print('🌍 Translation API response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['translatedText'].toString().toLowerCase();
      } else {
        print('⚠️ Translation failed, using original text.');
        return text;
      }
    } catch (e) {
      print("❌ Translation error: $e");
      return text; // fallback
    }
  }

  String normalizeText(String text) {
    return text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textController.dispose();
    super.dispose();
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
          "speech_to_gesture_avatar".tr,
          style: TextStyle(color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Visibility(
                  visible: !_isVideoReady,
                  child: ModelViewer(
                    src: "assets/standing.glb",
                    alt: "Standing Avatar",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    backgroundColor: Colors.white,
                  ),
                ),
                if (_isVideoReady && _controller != null && _controller!.value.isInitialized)
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "Enter text to convert to gesture",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _playVideoFromWords(_textController.text),
                ),
              ),
              onSubmitted: (value) => _playVideoFromWords(value),
            ),
          ),
          SizedBox(height: 20),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //     decoration: BoxDecoration(
          //       color: Colors.green,
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           "was_this_sign_easy_to_learn".tr,
          //           style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          //         ),
          //         SizedBox(width: 6),
          //         Icon(Icons.thumb_up, color: Colors.white),
          //         SizedBox(width: 6),
          //         Icon(Icons.thumb_down, color: Colors.white),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Obx(
                      () => Text(
                        _recognizedText.value.isEmpty
                            ? "Say something...".tr
                            : _recognizedText.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Nastaliq Urdu',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _toggleListening,
                  backgroundColor: Colors.green,
                  child: Icon(
                    isListening ? Icons.stop : Icons.mic,
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

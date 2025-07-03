import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslationService {
  static const String translationsBox = 'translations';
  static const String apiUrl = 'https://api.mymemory.translated.net/get'; // ✅ Free Translation API

  /// ✅ Ensure Hive storage is initialized before use
  static Future<void> initializeStorage() async {
    if (!Hive.isBoxOpen(translationsBox)) {
      await Hive.openBox(translationsBox);
    }
  }

  /// ✅ Function to load stored translations asynchronously
  static Future<Map<String, String>> loadStoredTranslations() async {
    var box = await Hive.openBox(translationsBox);
    return Map<String, String>.from(box.get('ur_PK', defaultValue: {}));
  }

  /// ✅ Fetch translation from API if not found locally
  static Future<String> fetchTranslation(String text, String targetLang) async {
    var box = await Hive.openBox(translationsBox);

    // 🔍 Check if translation is already stored
    if (box.containsKey('$targetLang-$text')) {
      return box.get('$targetLang-$text');
    }

    try {
      var response = await http.get(Uri.parse('$apiUrl?q=$text&langpair=en|$targetLang'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String translatedText = data['responseData']['translatedText'];

        // 💾 Store translation for future use
        await box.put('$targetLang-$text', translatedText);
        return translatedText;
      } else {
        return text; // ❌ Return original text if API fails
      }
    } catch (e) {
      return text; // ❌ Return original text if network error
    }
  }
}

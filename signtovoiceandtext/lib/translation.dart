import 'package:get/get.dart';
import 'translation_service.dart';

class AppTranslations extends Translations {
  static Map<String, String> storedTranslations = {};

  /// ✅ Load stored translations asynchronously before using the class
  static Future<void> initialize() async {
    storedTranslations = await TranslationService.loadStoredTranslations();
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'welcome': 'Welcome',
      'menu': 'Menu',
      'change_language': 'Change Language',
      'select_language': 'Select Language',
      'settings': 'Settings',
      'about': 'About',
      'sign_to_text': 'Gestures to Voice & Text',
      'sign_to_text_desc': 'Convert sign language into text and speech.',
      'text_to_sign': 'Voice & Text to Gestures',
      'text_to_sign_desc': 'Convert text and speech into sign language.',
      'start_recording': 'Start Recording',
      'stop_recording': 'Stop Recording',
      'waiting_for_sign': 'Waiting for Sign',
      'play_voice_output': 'Play Voice Output',
      'sign_to_text_and_voice': 'Sign to Text and Voice',
      'tap_the_mic_to_speak': 'Tap the Mic to Speak',
      'speech_to_gesture_avatar': 'Speech to Gesture Avatar',
      'hello': 'Hello',
      'yes': 'Yes',
      'no': 'No',
      'goodbye': 'Goodbye',
      'thank_you': 'Thank You',
      'i_love_you': 'I Love You',
      'no_cameras_found': 'No cameras found',
      'error_initializing_camera': 'Error initializing camera',
      'processing_signs': 'Processing signs...',
      'recognized_sign': 'Recognized Sign: Hello',
      'speech_to_gesture_avatar': 'Speech to Gesture Avatar',
      'was_this_sign_easy_to_learn': 'Was this sign easy to learn?',
      'tap_the_mic_to_speak': 'Tap the mic to speak',
      'failed_to_load_camera': 'Failed to load camera'
    },
    'ur_PK': storedTranslations.isNotEmpty ? storedTranslations : {
      'welcome': 'خوش آمدید',
      'menu': 'مینو',
      'change_language': 'زبان تبدیل کریں',
      'select_language': 'زبان منتخب کریں',
      'settings': 'ترتیبات',
      'about': 'کے بارے میں',
      'sign_to_text': 'اشاروں کو آواز اور متن میں تبدیل کریں',
      'sign_to_text_desc': 'اشاروں کی زبان کو متن اور تقریر میں تبدیل کریں۔',
      'text_to_sign': 'آواز اور متن کو اشاروں میں تبدیل کریں',
      'text_to_sign_desc': 'متن اور تقریر کو اشاروں میں تبدیل کریں۔',
      'start_recording': 'ریکارڈنگ شروع کریں',
      'stop_recording': 'ریکارڈنگ بند کریں',
      'waiting_for_sign': 'اشارے کا انتظار ہو رہا ہے',
      'play_voice_output': 'آواز چلائیں',
      'sign_to_text_and_voice': 'اشارے کو متن اور آواز میں تبدیل کریں',
      'tap_the_mic_to_speak': 'بولنے کے لیے مائیکروفون کو چھوئیں',
      'speech_to_gesture_avatar': 'تقریر کو اشارے میں تبدیل کرنے والا اوتار',
      'hello': 'ہیلو',
      'yes': 'ہاں',
      'no': 'نہیں',
      'goodbye': 'الوداع',
      'thank_you': 'شکریہ',
      'i_love_you': 'میں تم سے محبت کرتا ہوں',
      'no_cameras_found': 'کوئی کیمرہ نہیں ملا',
      'error_initializing_camera': 'کیمرہ شروع کرنے میں خرابی',
      'processing_signs': 'اشاروں پر کارروائی ہو رہی ہے...',
      'recognized_sign': 'پہچانا گیا اشارہ: ہیلو',
      'speech_to_gesture_avatar': 'تقریر کو اشارے میں تبدیل کرنے والا اوتار',
      'was_this_sign_easy_to_learn': 'کیا یہ اشارہ سیکھنا آسان تھا؟',
      'tap_the_mic_to_speak': 'بولنے کے لیے مائیکروفون کو چھوئیں',
      'say_something': 'کچھ بولیں',
      'failed_to_load_camera': 'کیمرہ لوڈ کرنے میں ناکام'
    },
  };

  /// 🔹 **Get Translation Dynamically**
  Future<String> getTranslation(String key, String languageCode) async {
    if (keys[languageCode]?.containsKey(key) ?? false) {
      return keys[languageCode]![key]!; // ✅ Found in manual translations
    } else {
      return await TranslationService.fetchTranslation(key, languageCode); // 🌍 Fetch from API
    }
  }
}

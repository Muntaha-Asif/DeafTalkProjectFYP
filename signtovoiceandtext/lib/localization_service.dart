import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
  ];

  static void changeLocale(String langCode) {
    Locale locale = _getLocaleFromLanguage(langCode);
    Get.updateLocale(locale);
  }

  static Locale _getLocaleFromLanguage(String langCode) {
    switch (langCode) {
      case 'ur':
        return Locale('ur', 'PK');
      case 'en':
      default:
        return Locale('en', 'US');
    }
  }
}

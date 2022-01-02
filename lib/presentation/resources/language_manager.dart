import 'package:flutter/material.dart';

enum LanguageType { english, spanish }

const String spanish = 'es';
const String english = 'en';
const String assetsPathLocalizations = 'assets/translations';
const spanishLocal = Locale('es', 'ES');
const englishLocal = Locale('en', 'US');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.spanish:
        return spanish;
    }
  }
}

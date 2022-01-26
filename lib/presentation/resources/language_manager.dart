import 'dart:ui';

enum LanguageType { ENGLISH, PORTUGUESE }

const String ASSETS_PATH_LOCALIZATIONS = "assets/translations";

const String ENGLISH = "en";
const String PORTUGUESE = "pt";
const Locale ENGLISH_LOCAL = Locale("en", "US");
const Locale PORTUGUESE_LOCAL = Locale("pt", "BR");

extension LanguageTypeExtesion on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.PORTUGUESE:
        return PORTUGUESE;
    }
  }
}

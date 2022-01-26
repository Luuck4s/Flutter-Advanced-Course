import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_course/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED = "PREFS_KEY_IS_USER_LOGGED";

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.PORTUGUESE.getValue()) {
      _sharedPreferences.setString(
        PREFS_KEY_LANG,
        LanguageType.ENGLISH.getValue(),
      );
    } else {
      _sharedPreferences.setString(
        PREFS_KEY_LANG,
        LanguageType.PORTUGUESE.getValue(),
      );
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();

    if (currentLanguage == LanguageType.PORTUGUESE.getValue()) {
      return PORTUGUESE_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  Future<void> setOnBoardingScreenView() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isOnBoardingScreenView() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setIsUserLoggedId() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED, true);
  }

  Future<bool> isUserLoggedId() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED);
  }
}

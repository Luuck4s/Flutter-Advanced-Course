import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/app/di.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_course/presentation/resources/language_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    EasyLocalization(
      supportedLocales: [ENGLISH_LOCAL, PORTUGUESE_LOCAL],
      path: ASSETS_PATH_LOCALIZATIONS,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}

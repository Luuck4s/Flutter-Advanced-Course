import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/app/di.dart';

import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}

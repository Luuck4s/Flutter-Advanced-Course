import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/presentation/resources/strings_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.settings),
    );
  }
}

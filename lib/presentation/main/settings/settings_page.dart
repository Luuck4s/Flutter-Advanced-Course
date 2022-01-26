import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/app/app_prefs.dart';
import 'package:flutter_advanced_course/app/di.dart';
import 'package:flutter_advanced_course/data/data_source/local_data_source.dart';
import 'package:flutter_advanced_course/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppPreferences _appPreferences = instance<AppPreferences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          leading: Icon(Icons.language),
          trailing: Icon(Icons.arrow_forward),
          title: Text(
            AppStrings.changeLanguage,
            style: Theme.of(context).textTheme.headline4,
          ),
          onTap: _changeLanguage,
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          trailing: Icon(Icons.arrow_forward),
          title: Text(
            AppStrings.contactUs,
            style: Theme.of(context).textTheme.headline4,
          ),
          onTap: _contactUs,
        ),
        ListTile(
          leading: Icon(Icons.share),
          trailing: Icon(Icons.arrow_forward),
          title: Text(
            AppStrings.inviteYourFriend,
            style: Theme.of(context).textTheme.headline4,
          ),
          onTap: _inviteFriends,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          trailing: Icon(Icons.arrow_forward),
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.headline4,
          ),
          onTap: _logout,
        )
      ],
    );
  }

  void _changeLanguage() {}

  void _contactUs() {}

  void _inviteFriends() {}

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}

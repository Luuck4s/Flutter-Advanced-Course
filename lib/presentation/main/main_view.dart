import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/presentation/main/home_page.dart';
import 'package:flutter_advanced_course/presentation/main/notification_page.dart';
import 'package:flutter_advanced_course/presentation/main/search_page.dart';
import 'package:flutter_advanced_course/presentation/main/settings_page.dart';
import 'package:flutter_advanced_course/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings,
  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorManager.lightGrey,
            spreadRadius: AppSize.s1,
          )
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              label: titles[0],
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: titles[1],
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: titles[2],
              icon: Icon(Icons.notifications),
            ),
            BottomNavigationBarItem(
              label: titles[3],
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}

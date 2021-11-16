import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/color_manager.dart';

class SplasView extends StatefulWidget {
  const SplasView({Key? key}) : super(key: key);

  @override
  _SplasViewState createState() => _SplasViewState();
}

class _SplasViewState extends State<SplasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(
          image: AssetImage(
            ImagesAssets.splashLogo,
          ),
        ),
      ),
    );
  }
}

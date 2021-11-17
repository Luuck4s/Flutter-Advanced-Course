import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/routes_manager.dart';

class SplasView extends StatefulWidget {
  const SplasView({Key? key}) : super(key: key);

  @override
  _SplasViewState createState() => _SplasViewState();
}

class _SplasViewState extends State<SplasView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(
            ImagesAssets.splashLogo,
          ),
        ),
      ),
    );
  }
}

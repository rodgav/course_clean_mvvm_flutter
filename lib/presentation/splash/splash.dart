import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juliaca_store0/app/app_prefs.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/presentation/resources/assets_manager.dart';
import 'package:juliaca_store0/presentation/resources/color_manager.dart';
import 'package:juliaca_store0/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppPreferences _appPreferences = instance<AppPreferences>();

  Timer? _timer;

  void _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  void _goNext() async {
    if (await _appPreferences.isUserLoggedIn()) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      if (await _appPreferences.isOnBoardingScreenViewed()) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoardinghRoutes);
      }
    }
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
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
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}

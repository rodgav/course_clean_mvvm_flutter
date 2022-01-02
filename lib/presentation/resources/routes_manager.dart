import 'package:flutter/material.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/presentation/forgot_password/forgot_password.dart';
import 'package:juliaca_store0/presentation/login/login.dart';
import 'package:juliaca_store0/presentation/main/main.dart';
import 'package:juliaca_store0/presentation/on_boarding/onboarding.dart';
import 'package:juliaca_store0/presentation/register/register.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:juliaca_store0/presentation/splash/splash.dart';
import 'package:juliaca_store0/presentation/store_details/store_details.dart';
import 'package:easy_localization/easy_localization.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardinghRoutes = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardinghRoutes:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound).tr(),
              ),
              body: Center(child: const Text(AppStrings.noRouteFound).tr()),
            ));
  }
}

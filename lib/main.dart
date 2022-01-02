import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:juliaca_store0/app/app.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/presentation/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initModule();
  runApp(EasyLocalization(
      supportedLocales: const [englishLocal, spanishLocal],
      path: assetsPathLocalizations,
      child: Phoenix(child: const MyApp())));
}

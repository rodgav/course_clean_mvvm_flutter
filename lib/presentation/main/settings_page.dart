import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juliaca_store0/app/app_prefs.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/data/data_source/local_data_source.dart';
import 'package:juliaca_store0/presentation/resources/assets_manager.dart';
import 'package:juliaca_store0/presentation/resources/routes_manager.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:juliaca_store0/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _appPreferences = instance<AppPreferences>();
  final _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing:  SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          title: Text(
            AppStrings.changeLanguage,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          onTap: _changeLanguage,
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing:  SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          title: Text(
            AppStrings.contactUs,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          onTap:  _contactUs,
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing:  SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          title: Text(
            AppStrings.inviteYourFriends,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          onTap:  _inviteFriend,
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          onTap:  _logout,
        ),
      ],
    );
  }

  void _changeLanguage() {
    _appPreferences.setAppLanguage();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}

  void _inviteFriend() {}

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}

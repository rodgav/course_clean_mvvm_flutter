import 'package:flutter/material.dart';
import 'package:juliaca_store0/presentation/main/home/home_page.dart';
import 'package:juliaca_store0/presentation/main/notifications_page.dart';
import 'package:juliaca_store0/presentation/main/search_page.dart';
import 'package:juliaca_store0/presentation/main/settings_page.dart';
import 'package:juliaca_store0/presentation/resources/color_manager.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:juliaca_store0/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePafe(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];
  final _titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];
  String _title = AppStrings.home.tr();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _title,
            style: Theme.of(context).textTheme.headline2,
          ),
          automaticallyImplyLeading: false),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: AppStrings.search.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: AppStrings.notifications.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: AppStrings.settings.tr()),
            ]),
      ),
    );
  }

  void onTap(int index) {
    _currentIndex = index;
    _title = _titles[index];
    setState(() {});
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iplik/pages/main/account_view/account_view.dart';
import 'package:iplik/pages/main/lif_view/lif_view.dart';
import 'package:iplik/pages/main/search_view/search_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [
    const LifView(),
    const SearchView(),
    const AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 25),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 25),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return pages[index];
          },
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/pages/examples/examples_page.dart';
import 'package:flutter_sample_app/pages/placeholder/placeholder_page.dart';
import 'package:flutter_sample_app/pages/settings/settings_page.dart';
import 'package:flutter_sample_app/shared/extensions/iterable_extensions.dart';

class Page {
  final String navBarItemLabel;
  final Widget navBarIcon;
  final Widget page;
  final String? pageTitle;
  const Page(
      {required this.navBarItemLabel,
      required this.navBarIcon,
      required this.page,
      this.pageTitle});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Page> _pages = [
    const Page(
        navBarItemLabel: 'Placeholder',
        navBarIcon: Icon(Icons.notifications),
        page: PlaceholderPage(),
        pageTitle: null),
    const Page(
        navBarItemLabel: 'Examples',
        navBarIcon: Icon(Icons.gamepad),
        pageTitle: 'Examples',
        page: ExamplesPage()),
    const Page(
        navBarItemLabel: 'Settings',
        navBarIcon: Icon(Icons.gamepad),
        pageTitle: 'Settings',
        page: SettingsPage())
  ];

  @override
  Widget build(BuildContext context) {
    final Page _currentPage = _pages.elementAt(_selectedIndex);

    return Scaffold(
        appBar: AppBar(
          title: _currentPage.pageTitle != null
              ? Text(_currentPage.pageTitle!)
              : const Text('Default title'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _pages.mapIndexed((pageMapEntry) {
            return BottomNavigationBarItem(
                icon: pageMapEntry.value.navBarIcon,
                label: pageMapEntry.value.navBarItemLabel);
          }).toList(),
          currentIndex: _selectedIndex,
          onTap: _onBottomNavBarItemTap,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages.map((e) => e.page).toList(),
        ));
  }

  _onBottomNavBarItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

import 'package:eventara/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/index_nav_provider.dart';
import 'core/styles/app_color.dart';
import 'feature-home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Letakkan screen di sini (sesuain indexnya dengan item di bottom nav)
  final List<Widget> _pages = [
    const HomeScreen(),
    const TestScreen(),
    const TestScreen(),
    const TestScreen(),
    const TestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<IndexNavProvider>(
      builder: (context, navProvider, child) {
        return Scaffold(
          body: IndexedStack(
            index: navProvider.idxBottomNavbar,
            children: _pages,
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: navProvider.idxBottomNavbar,
              onTap: (index) {
                navProvider.setIdxBottomNavbar = index;
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColor.orange.color,
              iconSize: 40,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: navProvider.idxBottomNavbar == 0
                        ? AppColor.orange.color
                        : Colors.black,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark,
                    color: navProvider.idxBottomNavbar == 1
                        ? AppColor.orange.color
                        : Colors.black,
                  ),
                  label: 'Bookmark',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    color: navProvider.idxBottomNavbar == 2
                        ? AppColor.orange.color
                        : Colors.black,
                  ),
                  label: 'Add Event',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.auto_awesome,
                    color: navProvider.idxBottomNavbar == 3
                        ? AppColor.orange.color
                        : Colors.black,
                  ),
                  label: 'Asisten AI',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: navProvider.idxBottomNavbar == 4
                        ? AppColor.orange.color
                        : Colors.black,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

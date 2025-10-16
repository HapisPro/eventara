import 'package:eventara/features/chatbot/chatbot_screen.dart';
import 'package:eventara/features/profile/profile_screen.dart';
import 'package:eventara/features/add_event/add_event_screen.dart';
import 'package:eventara/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/index_nav_provider.dart';
import 'features/home/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Halaman sesuai index bottom navbar
  final List<Widget> _pages = [
    const HomeScreen(),
    const TestScreen(),
    const AddEventScreen(),
    const ChatBotScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF0096C7);

    return Consumer<IndexNavProvider>(
      builder: (context, navProvider, child) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: navProvider.idxBottomNavbar,
            children: _pages,
          ),

          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: navProvider.idxBottomNavbar,
                  onTap: (index) => navProvider.setIdxBottomNavbar = index,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  showUnselectedLabels: false,
                  showSelectedLabels: true,
                  selectedItemColor: primaryColor,
                  unselectedItemColor: Colors.black54,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  unselectedLabelStyle: const TextStyle(fontSize: 11),

                  items: [
                    _buildNavItem(
                      icon: Icons.home_rounded,
                      label: "Home",
                      isActive: navProvider.idxBottomNavbar == 0,
                      activeColor: primaryColor,
                    ),
                    _buildNavItem(
                      icon: Icons.bookmark_rounded,
                      label: "Bookmark",
                      isActive: navProvider.idxBottomNavbar == 1,
                      activeColor: primaryColor,
                    ),
                    _buildNavItem(
                      icon: Icons.add_circle_rounded,
                      label: "Add Event",
                      isActive: navProvider.idxBottomNavbar == 2,
                      activeColor: primaryColor,
                      isCenter: true,
                    ),
                    _buildNavItem(
                      icon: Icons.auto_awesome_rounded,
                      label: "Asisten AI",
                      isActive: navProvider.idxBottomNavbar == 3,
                      activeColor: primaryColor,
                    ),
                    _buildNavItem(
                      icon: Icons.person_rounded,
                      label: "Profile",
                      isActive: navProvider.idxBottomNavbar == 4,
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Fungsi bantu untuk membuat item navbar dengan efek aktif
  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    bool isCenter = false,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(6),
        decoration: isCenter
            ? BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    activeColor.withOpacity(0.9),
                    const Color(0xFF00B4D8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              )
            : null,
        child: Icon(
          icon,
          size: isCenter ? 40 : 28,
          color: isCenter
              ? Colors.white
              : (isActive ? activeColor : Colors.black54),
        ),
      ),
      label: label,
    );
  }
}

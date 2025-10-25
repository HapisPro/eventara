import 'package:eventara/core/styles/app_color.dart';
import 'package:eventara/features/chatbot/chatbot_screen.dart';
import 'package:eventara/features/home/screens/bookmark_screen.dart';
import 'package:eventara/features/profile/profile_screen.dart';
import 'package:eventara/features/add_event/add_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/index_nav_provider.dart';
import 'features/bookmark/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const BookmarkScreen(),
    const AddEventScreen(),
    const ChatBotScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.1),
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
                data: theme.copyWith(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: navProvider.idxBottomNavbar,
                  onTap: (index) => navProvider.setIdxBottomNavbar = index,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: theme.colorScheme.surface,
                  elevation: 0,
                  showUnselectedLabels: false,
                  showSelectedLabels: true,
                  selectedItemColor: theme.colorScheme.primary,
                  unselectedItemColor: theme.colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
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
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      icon: Icons.bookmark_rounded,
                      label: "Bookmark",
                      isActive: navProvider.idxBottomNavbar == 1,
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      icon: Icons.add_circle_rounded,
                      label: "Add Event",
                      isActive: navProvider.idxBottomNavbar == 2,
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      isCenter: true,
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      icon: Icons.auto_awesome_rounded,
                      label: "Asisten AI",
                      isActive: navProvider.idxBottomNavbar == 3,
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      isDark: isDark,
                    ),
                    _buildNavItem(
                      icon: Icons.person_rounded,
                      label: "Profile",
                      isActive: navProvider.idxBottomNavbar == 4,
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      isDark: isDark,
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

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
    required bool isDark,
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
                  colors: isDark
                      ? [
                          AppColor.primaryLight.color.withValues(alpha: 0.9),
                          AppColor.primaryLight.color,
                        ]
                      : [
                          activeColor.withValues(alpha: 0.9),
                          const Color(0xFF00B4D8),
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3),
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
              ? (isDark ? Colors.black : Colors.white)
              : (isActive ? activeColor : inactiveColor),
        ),
      ),
      label: label,
    );
  }
}

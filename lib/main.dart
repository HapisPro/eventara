import 'package:eventara/core/shared_preference_provider.dart';
import 'package:eventara/data/services/bookmark_service.dart';
import 'package:eventara/data/services/local_notification_service.dart';
import 'package:eventara/data/services/shared_preferences_service.dart';
import 'package:eventara/features/auth/welcome_screen.dart';
import 'package:eventara/main_screen.dart';
import 'package:eventara/providers/auth_provider.dart';
import 'package:eventara/providers/bookmark_provider.dart';
import 'package:eventara/providers/event_provider.dart';
import 'package:eventara/providers/home_provider.dart';
import 'package:eventara/providers/notification_provider.dart';
import 'package:eventara/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/apptheme_provider.dart';
import 'core/index_nav_provider.dart';
import 'core/styles/app_theme.dart';

// TODO: add event (also improve the ux such as fix the used icon, and text area for description)
// TODO: admin page and functions
// TODO: add calendar
// TODO: notification
// TODO: Chatbot integration

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://eqeurwwtvrfipeczfpru.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxZXVyd3d0dnJmaXBlY3pmcHJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwMDgwMDksImV4cCI6MjA3NjU4NDAwOX0.vAOe-u80IOV5ePpSoBeFVL1Z4eb8bSjy5PiXx7aR4TQ',
  );

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  final sharedPreferencesService = SharedPreferencesService(sharedPreferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              SharedPreferenceProvider(sharedPreferencesService)..init(),
        ),
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),

        ChangeNotifierProvider(
          create: (_) => BookmarkProvider(BookmarkService()),
        ),
        Provider<LocalNotificationService>(
          create: (_) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              NotificationProvider(context.read<LocalNotificationService>()),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppThemeProvider, SharedPreferenceProvider>(
      builder: (context, themeProvider, sharedPrefProvider, child) {
        return MaterialApp(
          title: 'Eventara',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: AuthChecker(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// Widget to check authentication status
class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferenceProvider>(
      builder: (context, sharedPrefProvider, child) {
        if (sharedPrefProvider.isLogin) {
          return const MainScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}

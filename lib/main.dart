import 'package:eventara/features/auth/welcome_screen.dart';
import 'package:eventara/providers/auth_provider.dart';
import 'package:eventara/providers/event_provider.dart';
import 'package:eventara/providers/home_provider.dart';
import 'package:eventara/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/index_nav_provider.dart';
import 'core/styles/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://eqeurwwtvrfipeczfpru.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxZXVyd3d0dnJmaXBlY3pmcHJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwMDgwMDksImV4cCI6MjA3NjU4NDAwOX0.vAOe-u80IOV5ePpSoBeFVL1Z4eb8bSjy5PiXx7aR4TQ',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventara',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

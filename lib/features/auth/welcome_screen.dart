import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventara/features/auth/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            Text(
              "Eventara",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: const Color(0xFF0096C7),
              ),
            ),

            const SizedBox(height: 30),

            SvgPicture.asset(
              'assets/vector/welcome.svg',
              width: size.width * 0.7,
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Jelajahi Budaya Indonesia\ndalam Satu Genggaman",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  letterSpacing: 0.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Temukan beragam event budaya, festival, dan kegiatan menarik dari berbagai daerah di Indonesia secara mudah dan cepat.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0096C7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Mulai Sekarang",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

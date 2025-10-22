import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svgAsset;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          "Eventara",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        SvgPicture.asset(svgAsset, width: 220, height: 220),
        const SizedBox(height: 30),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

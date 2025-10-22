import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onTap;

  const TextLink({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        text: normalText,
        style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
        children: [
          TextSpan(
            text: linkText,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

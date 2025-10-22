import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String content;
  final ThemeData theme;
  final bool isHighlight;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.content,
    required this.theme,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlight
            ? iconColor.withOpacity(0.1)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlight
              ? iconColor.withOpacity(0.3)
              : theme.colorScheme.onSurface.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.onBackground,
                  height: 1.5,
                  fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:eventara/core/styles/app_color.dart';
import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;
  final bool isPhone;

  const ContactSection({
    super.key,
    required this.icon,
    required this.label,
    required this.theme,
    this.isPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.accent.color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColor.accent.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isPhone)
            Icon(
              Icons.phone_in_talk_rounded,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
              size: 20,
            ),
        ],
      ),
    );
  }
}

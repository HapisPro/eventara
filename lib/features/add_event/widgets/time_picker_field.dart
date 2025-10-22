import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final String label;

  const TimePickerField({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    this.label = "Pilih jam",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                  primary: theme.colorScheme.primary,
                  onPrimary: theme.colorScheme.onPrimary,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) onTimeSelected(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              color: theme.colorScheme.primary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              selectedTime == null
                  ? label
                  : selectedTime!.format(context),
              style: TextStyle(
                fontSize: 16,
                color: selectedTime == null
                    ? theme.colorScheme.onSurface.withOpacity(0.6)
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
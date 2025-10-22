import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final String label;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.label = "Pilih tanggal",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2030),
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
        if (picked != null) onDateSelected(picked);
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
              Icons.calendar_today_rounded,
              color: theme.colorScheme.primary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? label
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: TextStyle(
                fontSize: 16,
                color: selectedDate == null
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

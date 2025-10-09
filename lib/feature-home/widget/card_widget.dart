import 'package:flutter/material.dart';

import '../../core/styles/app_color.dart';

class UpcomingEventCard extends StatelessWidget {
  final String title;
  final String location;
  final String dateTime;
  final String? imageUrl;
  final VoidCallback? onTap;

  const UpcomingEventCard({
    super.key,
    required this.title,
    required this.location,
    required this.dateTime,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image or icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.blue.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 30,
                          );
                        },
                      ),
                    )
                  : const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 12),

            // Event details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateTime,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

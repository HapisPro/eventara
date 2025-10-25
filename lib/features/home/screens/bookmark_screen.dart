import 'package:eventara/features/detail/detail_page.dart';
import 'package:eventara/features/home/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../providers/bookmark_provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, _) {
          final bookmarks = provider.bookmarks;

          if (bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Belum ada event yang dibookmark",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final event = bookmarks[index];
              return CardWidget(
                title: event.title,
                location: event.province,
                dateTime: DateFormat('HH:mm').format(event.startTime),
                imageUrl: event.imageUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(eventData: event),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

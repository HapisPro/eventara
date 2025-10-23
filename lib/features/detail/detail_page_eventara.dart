import 'package:eventara/core/app_snackbar_widget.dart';
import 'package:eventara/core/styles/app_color.dart';
import 'package:eventara/features/auth/widgets/primary_button.dart';
import 'package:eventara/features/detail/widgets/contact_section.dart';
import 'package:eventara/features/detail/widgets/detail_section.dart';
import 'package:eventara/features/detail/widgets/info_card.dart';
import 'package:eventara/providers/bookmark_provider.dart';
import 'package:eventara/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/event_model.dart';
import 'package:intl/intl.dart';

class DetailPageEventara extends StatelessWidget {
  final EventModel eventData;
  const DetailPageEventara({super.key, required this.eventData});

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bookmarkProvider = context.read<BookmarkProvider>();
    final notifProvider = context.watch<NotificationProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 8, top: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4, top: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8),
              ],
            ),
            child: IconButton(
              onPressed: () {
                bookmarkProvider.toggleBookmark(eventData);
              },
              icon: Icon(
                context.watch<BookmarkProvider>().isBookmarked(
                      eventData.id ?? '',
                    )
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: Colors.amber,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, top: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8),
              ],
            ),
            child: IconButton(
              onPressed: () async {
                await notifProvider.toggleNotificationForEvent(
                  eventId: eventData.id ?? '',
                  id: eventData.id.hashCode,
                  title: "Pengingat: ${eventData.title}",
                  body: "Jangan lewatkan event seru!",
                  eventDateTime: eventData.startTime,
                );
              },
              icon: Icon(
                notifProvider.isNotificationActive(eventData.id ?? '')
                    ? Icons.notifications_active
                    : Icons.notifications_none,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Section
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
                child: eventData.imageUrl != null
                    ? Image.network(
                        eventData.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildImagePlaceholder(theme);
                        },
                      )
                    : _buildImagePlaceholder(theme),
              ),

              Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Event Title & Info
              Positioned(
                left: 20,
                bottom: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      eventData.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Date & Time Chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(
                          icon: Icons.calendar_today_rounded,
                          label: _formatDate(eventData.date),
                          color: AppColor.primary.color,
                        ),
                        _buildInfoChip(
                          icon: Icons.access_time_rounded,
                          label: _formatTime(eventData.startTime),
                          color: AppColor.accent.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description Section
                  DetailSection(
                    title: "Deskripsi",
                    icon: Icons.description_rounded,
                    child: Text(
                      eventData.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.colorScheme.onBackground,
                        height: 1.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Location Section
                  DetailSection(
                    title: "Lokasi",
                    icon: Icons.location_on_rounded,
                    child: InfoCard(
                      icon: Icons.place_rounded,
                      iconColor: theme.colorScheme.primary,
                      content:
                          "${eventData.address}, ${eventData.city}, ${eventData.province}",
                      theme: theme,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Ticket Info Section
                  DetailSection(
                    title: "Informasi Tiket",
                    icon: Icons.confirmation_number_rounded,
                    child: InfoCard(
                      icon: Icons.confirmation_num_rounded,
                      iconColor: AppColor.accent.color,
                      content: eventData.ticketInfo,
                      theme: theme,
                      isHighlight: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Organizer Contact Section
                  DetailSection(
                    title: "Kontak Penyelenggara",
                    icon: Icons.contact_phone_rounded,
                    child: Column(
                      children: [
                        ContactSection(
                          icon: Icons.person_rounded,
                          label: eventData.organizer,
                          theme: theme,
                        ),
                        const SizedBox(height: 12),
                        ContactSection(
                          icon: Icons.phone_rounded,
                          label: eventData.contact,
                          theme: theme,
                          isPhone: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: 'Tambahkan ke kalender',
                      onPressed: () => {},
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.6),
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.event_rounded, size: 100, color: Colors.white54),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

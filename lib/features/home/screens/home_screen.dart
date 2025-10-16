import 'package:flutter/material.dart';

import '../../../core/styles/app_color.dart';
import '../widgets/card_widget.dart';
import '../widgets/live_event_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Hardcoded data for demonstration
  final List<Map<String, String>> upcomingEvents = [
    {
      'title': 'Lorem Ipsum',
      'location': 'Riau',
      'dateTime': 'March 24. 14.00 Am',
    },
    {
      'title': 'Lorem Ipsum',
      'location': 'Riau',
      'dateTime': 'March 24. 14.00 Am',
    },
    {
      'title': 'Lorem Ipsum',
      'location': 'Riau',
      'dateTime': 'March 24. 14.00 Am',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Location header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.blue.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColor.orange.color,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Toronto,Canada',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Date and welcome message
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's March 24th",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      'Welcome, Jimmy',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColor.orange.color,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.tune, color: AppColor.orange.color),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Live Event section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Live Event',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Live Event card
              LiveEventCard(
                title: 'Lorem Ipsum',
                organizer: 'Suku Abc',
                distance: '18,5 Km',
                location: 'Pekanbaru,Riau',
                onTap: () {
                  // Navigate to event details
                  print('Live event tapped');
                },
              ),

              const SizedBox(height: 32),

              // Upcoming Event section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Upcoming Event',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Upcoming events list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upcomingEvents.length,
                itemBuilder: (context, index) {
                  final event = upcomingEvents[index];
                  return UpcomingEventCard(
                    title: event['title']!,
                    location: event['location']!,
                    dateTime: event['dateTime']!,
                    onTap: () {
                      // Navigate to event details
                      print('Upcoming event ${index + 1} tapped');
                    },
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

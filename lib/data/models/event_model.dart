class EventModel {
  final String title;
  final String? id;
  final String description;
  final String address;
  final String city;
  final String province;
  final String ticketInfo;
  final DateTime date;
  final DateTime startTime; 
  final String organizer;
  final String contact;
  final String? imageUrl;

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.city,
    required this.province,
    required this.ticketInfo,
    required this.date,
    required this.startTime,
    required this.organizer,
    required this.contact,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'address': address,
      'city': city,
      'province': province,
      'ticketInfo': ticketInfo,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'organizer': organizer,
      'contact': contact,
      'imageUrl': imageUrl,
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    return EventModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      province: map['province'] ?? '',
      ticketInfo: map['ticketInfo'] ?? '',
      date: DateTime.parse(map['date']),
      startTime: map['startTime'] != null
          ? DateTime.parse(map['startTime'])
          : DateTime.now(),
      organizer: map['organizer'] ?? '',
      contact: map['contact'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }
}

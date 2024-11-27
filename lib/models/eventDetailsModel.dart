class eventDetailsModel {
  final String eventName;
  final String eventDiscription;
  final String eventTime;
  final String eventDate;
  final String eventVenue;
  final String eventMode;
  final String eventType;
  final String eventWeblink;
  final String eventSocialLink;
  final String bannerImage;
  final int eventSeats;
  final String managerId; // New field for the manager's ID

  eventDetailsModel({
    required this.eventName,
    required this.eventDiscription,
    required this.eventTime,
    required this.eventDate,
    required this.eventVenue,
    required this.eventMode,
    required this.eventType,
    required this.eventWeblink,
    required this.eventSocialLink,
    required this.bannerImage,
    required this.eventSeats,
    required this.managerId, // Include in constructor
  });

  // Modify toJson method to include managerId
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'eventDiscription': eventDiscription,
      'eventTime': eventTime,
      'eventDate': eventDate,
      'eventVenue': eventVenue,
      'eventMode': eventMode,
      'eventType': eventType,
      'eventWeblink': eventWeblink,
      'eventSocialLink': eventSocialLink,
      'bannerImage': bannerImage,
      'eventSeats': eventSeats,
      'managerId': managerId, // Include managerId in the JSON
    };
  }
}

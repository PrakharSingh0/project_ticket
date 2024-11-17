class eventDetailsModel {
  final String? id;
  final String? eventName;
  final String? eventDiscription;
  final String? eventDate;
  final String? eventTime;
  final String? eventVenue;
  final String? eventMode;
  final String? eventType;
  final String? eventWeblink;
  final String? eventSocialLink;
  final int? eventSeats;

  const eventDetailsModel({
    this.id,
    required this.eventName,
    required this.eventDiscription,
    required this.eventDate,
    required this.eventTime,
    required this.eventVenue,
    required this.eventMode,
    required this.eventType,
    required this.eventWeblink,
    required this.eventSocialLink,
    required this.eventSeats,
  });


  toJson(){
    return{
      "eventName":eventName,
      "eventDiscription":eventDiscription,
      "eventDate":eventDate,
      "eventTime":eventTime,
      "eventVenue":eventVenue,
      "eventMode":eventMode,
      "eventType":eventType,
      "eventWebLink":eventWeblink,
      "eventSocialLink":eventSocialLink,
      "eventSeats":eventSeats,

    };
  }

}

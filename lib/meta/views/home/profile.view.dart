class Profile {
  Profile({
    required this.id,
    required this.sender_prof,
    required this.reciever_prof,
    required this.booking_id,
    required this.createdAt,

  });

  /// User ID of the profile
  final String id;

  /// Username of the profile
  final List<String> sender_prof;

  final List<String> reciever_prof;

  final int booking_id;


  /// Date and time when the profile was created
  final DateTime createdAt;

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        sender_prof = map['sender_prof'],
        reciever_prof = map['reciever_prof'],
        booking_id=map['booking_id'],
        createdAt = DateTime.parse(map['created_at']);
}


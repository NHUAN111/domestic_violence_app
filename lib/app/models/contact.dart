class Contact {
  int? contactId;
  String? userId;
  String? name;
  String? phoneNumber;

  Contact({
    this.contactId,
    this.userId,
    this.name,
    this.phoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactId: json['contactId'],
      userId: json['userId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contactId': contactId,
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}

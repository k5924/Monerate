
class MessageModel {
  String senderID;
  String firstName;
  String lastName;
  String message;
  DateTime createdAt;

  MessageModel({
    required this.senderID,
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'firstName': firstName,
      'lastName': lastName,
      'message': message,
      'createdAt': createdAt.toUtc(),
    };
  }

  @override
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderID: map['senderID'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      message: map['message'] as String,
      createdAt: map['createdAt'] as DateTime,
    );
  }
}

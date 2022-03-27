
class MessageModel {
  String userID;
  String firstName;
  String lastName;
  String message;
  DateTime createdAt;

  MessageModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'message': message,
      'createdAt': createdAt.toUtc(),
    };
  }

  @override
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      userID: map['userID'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      message: map['message'] as String,
      createdAt: map['createdAt'] as DateTime,
    );
  }
}

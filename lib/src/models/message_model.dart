/// This is the message model class which will structure how message objects look
class MessageModel {
  /// This variable will store the id of the sender
  String senderID;
  /// This variable will store the first name of the sender
  String firstName;
  /// This variable will store the last name of the sender
  String lastName;
  /// This variable will store the sent message
  String message;
  /// This variable will store the data the message was created
  DateTime createdAt;
/// This is the constructor for this class which requires a sender id, first name, last name, message and date time instance on initialization
  MessageModel({
    required this.senderID,
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.createdAt,
  });
/// This method converts an instance of message model to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'firstName': firstName,
      'lastName': lastName,
      'message': message,
      'createdAt': createdAt.toUtc(),
    };
  }
/// This method converts a map to a message model object
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

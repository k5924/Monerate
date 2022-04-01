/// This class structures the data for an individual chat instance
class ChatModel {
  /// This variable will store the id of the user who created the chat
  String userID;

  /// This variable will store the first name of the user who created the chat
  String firstName;

  /// This variable will store the last name of the user who created the chat
  String lastName;

  /// This variable will store the type of chat the user wants to conduct
  String chatType;

  /// This variable will store the date and time of the most recent message
  DateTime latestMessage;

  /// This constructor requires all fields be supplied on initialization
  ChatModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.chatType,
    required this.latestMessage,
  });

  /// This method converts a chat model instance to a map
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'chatType': chatType,
      'latestMessage': latestMessage.toUtc(),
    };
  }

  /// This method converts a map to a chat model instance
  @override
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      userID: map['userID'] as String,
      chatType: map['chatType'] as String,
      latestMessage: map['latestMessage'] as DateTime,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
}

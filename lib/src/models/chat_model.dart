import 'package:monerate/src/models/export.dart';

class ChatModel {
  String userID;
  String firstName;
  String lastName;
  String chatType;
  DateTime latestMessage;

  ChatModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.chatType,
    required this.latestMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'chatType': chatType,
      'latestMessage': latestMessage.toUtc(),
    };
  }

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

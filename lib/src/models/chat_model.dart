import 'package:monerate/src/models/export.dart';

class ChatModel {
  String userID;
  String firstName;
  String lastName;
  String chatType;
  DateTime latestMessage;
  List<MessageModel>? messages;

  ChatModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.chatType,
    required this.latestMessage,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'chatType': chatType,
      'latestMessage': latestMessage.toUtc(),
      'messages': messages,
    };
  }

  @override
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      userID: map['userID'] as String,
      chatType: map['chatType'] as String,
      latestMessage: map['latestMessage'] as DateTime,
      messages: map['messages'] as List<MessageModel>,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('Chat Model:', () {
    final DateTime time = DateTime(2000);
    final MessageModel message = MessageModel(
      senderID: 'userID',
      firstName: 'firstName',
      lastName: 'lastName',
      message: 'message',
      createdAt: time,
    );

    test('Populated ChatModel.toMap() returns supplied values for each field',
        () {
      final ChatModel chatModel = ChatModel(
        userID: 'userID',
        firstName: 'firstName',
        lastName: 'lastName',
        chatType: 'chatType',
        latestMessage: time,
        messages: [message],
      );

      expect(
        chatModel.toMap(),
        {
          'userID': 'userID',
          'firstName': 'firstName',
          'lastName': 'lastName',
          'chatType': 'chatType',
          'latestMessage': time.toUtc(),
          'messages': [message]
        },
      );
    });

    test('ChatModel.fromMap(map) returns map values in ChatModel format', () {
      final chatModel = ChatModel.fromMap(
        {
          'userID': 'userID',
          'firstName': 'firstName',
          'lastName': 'lastName',
          'chatType': 'chatType',
          'latestMessage': time,
          'messages': [message]
        },
      );
      expect(
        chatModel.toMap(),
        {
          'userID': 'userID',
          'firstName': 'firstName',
          'lastName': 'lastName',
          'chatType': 'chatType',
          'latestMessage': time.toUtc(),
          'messages': [message]
        },
      );
    });
  });
}

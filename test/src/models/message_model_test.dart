import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('Message Model:', () {
    final DateTime time = DateTime(2000);
    test('Populated Message.toMap() returns supplied values for each field',
        () {
      final MessageModel message = MessageModel(
        senderID: 'senderID',
        firstName: 'firstName',
        lastName: 'lastName',
        message: 'message',
        createdAt: time,
      );
      expect(
        message.toMap(),
        {
          'senderID': 'senderID',
          'firstName': 'firstName',
          'lastName': 'lastName',
          'message': 'message',
          'createdAt': time.toUtc(),
        },
      );
    });

    test('MessageModel.fromMap(map) returns map values in MessageModel format',
        () {
      final MessageModel message = MessageModel.fromMap({
        'senderID': 'senderID',
        'firstName': 'firstName',
        'lastName': 'lastName',
        'message': 'message',
        'createdAt': time,
      });

      expect(
        message.toMap(),
        {
          'senderID': 'senderID',
          'firstName': 'firstName',
          'lastName': 'lastName',
          'message': 'message',
          'createdAt': time.toUtc(),
        },
      );
    });
  });
}

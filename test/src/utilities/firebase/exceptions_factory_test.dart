import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {

  ExceptionsFactory exceptionsFactory;
  group('Exceptions Factory:', () {
    test('Weak password exception returns error', () {
      exceptionsFactory = ExceptionsFactory('weak-password');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'The password provided is too weak.');
    });

    test('Email already is use error returns error', () {
      exceptionsFactory = ExceptionsFactory('email-already-in-use');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'The account already exists for that email.');
    });

    test('Too many requests exception returns error', () {
      exceptionsFactory = ExceptionsFactory('too-many-requests');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'Too many requests, please try again later');
    });


    test('User not found exception returns error', () {
      exceptionsFactory = ExceptionsFactory('user-not-found');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'No user found for that email.');
    });

    test('Wrong password exception returns error', () {
      exceptionsFactory = ExceptionsFactory('wrong-password');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'Wrong password provided for that user.');
    });

    test('No network connection for Firebase', () {
      exceptionsFactory = ExceptionsFactory('network-request-failed');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'Problem connecting to the server, please check the network connection and try again later.');
    });

    test('Exception which is not predefined returns exception in plain text', () {
      exceptionsFactory = ExceptionsFactory('undefined-exception');
      final result = exceptionsFactory.exceptionCaught();
      expect(result, 'undefined-exception');
    });

  });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('UserModel:', () {
    late UserModel userModel;
    test('Empty UserModel.toMap() returns null for each field', () {
      userModel = UserModel();
      expect(
        userModel.toMap(),
        {
          'firstName': null,
          'lastName': null,
          'userType': null,
        },
      );
    });

    test('Populated UserModel.toMap() returns supplied value for each field',
        () {
      userModel = UserModel(
        firstName: 'firstName',
        lastName: 'lastName',
        userType: 'userType',
      );
      expect(
        userModel.toMap(),
        {
          'firstName': 'firstName',
          'lastName': 'lastName',
          'userType': 'userType',
        },
      );
    });

    test('UserModel.fromMap(map) returns map values in UserModel format', () {
      userModel = UserModel.fromMap(
        {
          'firstName': 'firstName',
          'lastName': 'lastName',
          'userType': 'userType',
        },
      );
      expect(
        userModel.toMap(),
        {
          'firstName': 'firstName',
          'lastName': 'lastName',
          'userType': 'userType',
        },
      );
    });

    test('getUserType() returns userType of UserModel instance', () {
      userModel = UserModel(
        firstName: 'firstName',
        lastName: 'lastName',
        userType: 'userType',
      );
      expect(
        userModel.getUserType(),
        'userType',
      );
    });
  });
}

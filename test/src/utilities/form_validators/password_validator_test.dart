import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Password Validator: ', () {
    test('Empty password returns error', () {
      final result = PasswordValidator().validatePassword('');
      expect(result, "A Password is required");
    });

    test('Password less than six characters returns error', () {
      final result = PasswordValidator().validatePassword('a');
      expect(result, "Enter a valid password (Minimum 6 chararacters)");
    });

    test('Password more than six characters doesnt give an error', () {
      final result = PasswordValidator().validatePassword('abcdef');
      expect(result, null);
    });

    // confirmPassword validates the second field thus we as the first field is validated above, we will focus on test cases for the second field

    test('Empty passwords returns error', () {
      final result = PasswordValidator().confirmPassword('', '');
      expect(result, "A Password is required");
    });

    test('If passwords are less than 6 characters, return error', () {
      final result = PasswordValidator().confirmPassword('', 'a');
      expect(result, "Enter a valid password (Minimum 6 chararacters)");
    });

    test('If passwords dont match, return an error', () {
      final result =
          PasswordValidator().confirmPassword('testing1234', 'testing123');
      expect(result, "Passwords do not match, please try again");
    });

    test('If passwords match, dont return an error', () {
      final result =
          PasswordValidator().confirmPassword('testing123', 'testing123');
      expect(result, null);
    });
  });
}

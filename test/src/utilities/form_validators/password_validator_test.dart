import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Password Validator: ', () {
    test('Empty password returns error', () {
      final result = PasswordValidator().validatePassword('');
      expect(result, "A Password is required to login");
    });

    test('Password less than six characters returns error', () {
      final result = PasswordValidator().validatePassword('a');
      expect(result, "Enter a valid password (Minimum 6 chararacters)");
    });

    test('Password more than six characters doesnt give an error', () {
      final result = PasswordValidator().validatePassword('abcdef');
      expect(result, null);
    });
  });
}

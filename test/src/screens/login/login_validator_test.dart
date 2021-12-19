
import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/screens/export.dart';

void main() {
  group('Login Screen Tests:', () {
    test('Empty email returns error', () {
      final result = validateEmail('');
      expect(result, "Please enter your email");
    });

    test('If email doesnt contain @ symbol, return error', () {
      final result = validateEmail('abc.co.uk');
      expect(result, "Please enter a valid email");
    });

    test('Empty password returns error', () {
      final result = validatePassword('');
      expect(result, "A Password is required to login");
    });

    test('Password less than six characters returns error', () {
      final result = validatePassword('a');
      expect(result, "Enter a valid password (Minimum 6 chararacters)");
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Email Validator:', () {
    test('Empty email returns error', () {
      final result = EmailValidator().validateEmail('');
      expect(result, "Please enter your email");
    });

    test('If email doesnt contain @ symbol, return error', () {
      final result = EmailValidator().validateEmail('abc.co.uk');
      expect(result, "Please enter a valid email");
    });

    test('If email contains @ symbol, dont return an error', () {
      final result = EmailValidator().validateEmail('k@lsbu.ac.uk');
      expect(result, null);
    });
  });
}

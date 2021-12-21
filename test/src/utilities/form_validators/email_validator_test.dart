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

    // confirmEmail validates the second field thus we as the first field is validated above, we will focus on test cases for the second field

    test('Empty emails returns error', () {
      final result = EmailValidator().confirmEmail('', '');
      expect(result, "Please enter your email");
    });

    test('If emails doesnt contain @ symbol, return error', () {
      final result = EmailValidator().confirmEmail('', 'abc.co.uk');
      expect(result, "Please enter a valid email");
    });

    test('If emails dont match, return an error', () {
      final result = EmailValidator().confirmEmail('abc@lsbu.ac.uk', 'k@lsbu.ac.uk');
      expect(result, "Emails do not match, please try again");
    });

    test('If emails match, dont return an error', () {
      final result = EmailValidator().confirmEmail('k@lsbu.ac.uk', 'k@lsbu.ac.uk');
      expect(result, null);
    });
    
  });
}

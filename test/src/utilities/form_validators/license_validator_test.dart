import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('License Validator: ', () {
    test('Empty License ID returns error', () {
      final result = LicenseValidator().validateLicense('');
      expect(
        result,
        "A License ID is required to sign up as a Financial Advisor",
      );
    });

    test('License ID less than six characters returns error', () {
      final result = LicenseValidator().validateLicense('a');
      expect(result, "Enter a valid License ID (Minimum 6 characters)");
    });

    test('License ID more than six characters doesnt give an error', () {
      final result = LicenseValidator().validateLicense('abcdef');
      expect(result, null);
    });
  });
}

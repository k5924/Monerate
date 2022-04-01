import 'package:monerate/src/utilities/export.dart';

/// This is the license validator class which extends the validator class
class LicenseValidator extends Validator {
  /// This method validates a license for presence and to ensure a license is a specific length
  String? validateLicense(String? value) {
    if (super.presenceDetection(value) == false) {
      return 'A License ID is required to sign up as a Financial Advisor';
    }
    if (!RegExp(r'^.{6,}$').hasMatch(value!)) {
      return "Enter a valid License ID (Minimum 6 characters)";
    }
    return null;
  }
}

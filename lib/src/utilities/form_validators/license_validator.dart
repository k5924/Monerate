import 'package:monerate/src/utilities/export.dart';

class LicenseValidator extends Validator {
  String? validateLicense(String? value) {
    if (super.presenceDetection(value) == false) {
      return 'A License ID is required to sign up as a Financial Advisor';
    }
    if (!RegExp(r'^.{6,}$').hasMatch(value!)) {
      return "Enter a valid License ID (Minimum 6 chararacters)";
    }
    return null;
  }
}

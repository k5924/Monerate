import 'package:monerate/src/utilities/export.dart';

class PasswordValidator extends Validator {
  String? validatePassword(String? value) {
    if (super.presenceDetection(value) == false) {
      return 'A Password is required to login';
    }
    if (!RegExp(r'^.{6,}$').hasMatch(value!)) {
      return "Enter a valid password (Minimum 6 chararacters)";
    }
  }

  String? confirmPassword(String? value1, String? value2) {
    final String? validationResult1 = validatePassword(value1);
    final String? validationResult2 = validatePassword(value2);
    if ((validationResult1 == null) & (validationResult2 == null)) {
      if (value1!.compareTo(value2!) != 0) {
        return "Passwords do not match, please try again";
      }
    }
    return validationResult2;
  }
}

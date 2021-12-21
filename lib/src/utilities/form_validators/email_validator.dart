import 'package:monerate/src/utilities/export.dart';

class EmailValidator extends Validator {
  String? validateEmail(String? value) {
    if (super.presenceDetection(value) == false) {
      return "Please enter your email";
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value!)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? confirmEmail(String? value1, String? value2) {
    final String? validationResult = validateEmail(value1);
    if (validationResult == null) {
      if (value1!.compareTo(value2!) != 0) {
        return "Emails do not match, please try again";
      }
    }
    return validationResult;
  }
}

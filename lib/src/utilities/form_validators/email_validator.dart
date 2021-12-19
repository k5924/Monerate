import 'package:monerate/src/utilities/export.dart';

class EmailValidator extends Validator{
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
}

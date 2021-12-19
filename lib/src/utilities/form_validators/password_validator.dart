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
}

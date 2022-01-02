import 'package:monerate/src/utilities/export.dart';

class NameValidator extends Validator {
  String? validateName(String? value) {
    if (super.presenceDetection(value) == false) {
      return "This field cant be left empty";
    }
    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
      return "Please enter a valid name";
    }
    return null;
  }
}

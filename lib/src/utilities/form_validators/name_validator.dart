import 'package:monerate/src/utilities/export.dart';

/// This is the name validator class which extends the validator class
class NameValidator extends Validator {
  /// This method checks for presence inside of the name string passed to the class
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

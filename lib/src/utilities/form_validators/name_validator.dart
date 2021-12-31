import 'package:monerate/src/utilities/export.dart';

class NameValidator extends Validator {
  String? validateName(String? value) {
    if (super.presenceDetection(value) == false) {
      return "This field cant be left empty";
    }
    return null;
  }
}

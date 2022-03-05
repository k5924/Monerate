import 'package:monerate/src/utilities/form_validators/export.dart';

class AmountValidator extends Validator {
  String? validateAmount(String? value) {
    if (super.presenceDetection(value) == false) {
      return 'An amount is required before adding the investment to your portfolio';
    }
    if (!RegExp(r'^[0-9]\d*(\.\d+)?$').hasMatch(value!)) {
      return "Enter a valid amount";
    }
    return null;
  }
}

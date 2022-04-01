import 'package:monerate/src/utilities/export.dart';

/// This is the amount validator class which extends the validator class
class AmountValidator extends Validator {
  /// This method verifies an amount for presence and that the amount is a valid floating point integer
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

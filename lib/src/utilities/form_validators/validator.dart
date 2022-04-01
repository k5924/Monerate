/// This is a class which Validates a specific string value against specific criteria
class Validator {
  /// This function determines if the value inside of the String passed to the function is empty
  bool presenceDetection(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }
}

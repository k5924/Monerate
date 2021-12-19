class Validator {
  bool presenceDetection(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }
}

bool presenceDetection(String? value) {
  if (value!.isEmpty) {
    return false;
  }
  return true;
}

String? validateEmail(String? value) {
  if (presenceDetection(value) == false) {
    return "Please enter your email";
  }
  if (!RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(value!)) {
    return "Please enter a valid email";
  }
  return null;
}

String? validatePassword(String? value) {
  if (presenceDetection(value)==false) {
    return 'A Password is required to login';
  }
  if (!RegExp(r'^.{6,}$').hasMatch(value!)) {
    return "Enter a valid password (Minimum 6 chararacters)";
  }
}

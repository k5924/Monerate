/// This is the exceptions factory class
class ExceptionsFactory {
  /// This variable will store the string equivalent of the caught exception
  final String exception;

  /// This constructor will assign the string exception to the exception variable
  ExceptionsFactory(this.exception);

  /// This method checks the exception against the exceptions in the switch case statement and returns a relevant error code
  String? exceptionCaught() {
    switch (exception) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'too-many-requests':
        return 'Too many requests, please try again later';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'network-request-failed':
        return 'Problem connecting to the server, please check the network connection and try again later.';
      default:
        return exception;
    }
  }
}

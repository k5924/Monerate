class ExceptionsFactory {
  final String exception;

  ExceptionsFactory(this.exception);

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

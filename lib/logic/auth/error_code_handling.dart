class ErrorCodeHandler {
  static String errorCodeDebug(String error) {
    if (error.contains("invalid-email")) {
      return "Invalid email address";
    } else if (error.contains("wrong-password")) {
      return "Incorrect password";
    } else if (error.contains("user-not-found")) {
      return "User does not exist";
    } else if (error.contains("missing-password")) {
      return "Please enter your password";
    } else if (error.contains("weak-password")) {
      return "Please should be at least 6 characters";
    } else if (error.contains("email-already-in-use")) {
      return "Email already in use";
    } else if (error.contains("too-many-requests")) {
      return "Too mant requests, try again later";
    }
    return error;
  }
}

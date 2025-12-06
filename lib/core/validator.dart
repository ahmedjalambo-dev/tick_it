class Validator {
  // A good practice is to define regex patterns as static final constants
  // to avoid recompiling them on every method call.
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final _uppercaseRegex = RegExp(r'[A-Z]');
  static final _lowercaseRegex = RegExp(r'[a-z]');
  static final _digitRegex = RegExp(r'\d');
  static final _specialCharRegex = RegExp(r'[@$!%*?&]');

  /// Validates an email address.
  /// Returns an error string if invalid, otherwise null.
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty.';
    }
    if (!_emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null; // Return null if validation is successful
  }

  /// Validates a password based on a set of rules.
  /// It checks for minimum length, and the presence of uppercase,
  /// lowercase, digit, and special characters sequentially,
  /// returning the first error found.
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!_uppercaseRegex.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!_lowercaseRegex.hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!_digitRegex.hasMatch(password)) {
      return 'Password must contain at least one number.';
    }
    if (!_specialCharRegex.hasMatch(password)) {
      return 'Password must contain at least one special character (@\$!%*?&).';
    }
    return null; // Return null if validation is successful
  }

  // The individual check methods can also be converted, though they
  // are primarily used by the composite `validatePassword` method above.

  /// Validates if the input has at least one uppercase letter.
  static String? validateHasUppercase(String input) {
    if (!_uppercaseRegex.hasMatch(input)) {
      return 'An uppercase letter is required.';
    }
    return null;
  }

  /// Validates if the input has at least one lowercase letter.
  static String? validateHasLowercase(String input) {
    if (!_lowercaseRegex.hasMatch(input)) {
      return 'A lowercase letter is required.';
    }
    return null;
  }

  /// Validates if the input has at least one digit.
  static String? validateHasDigit(String input) {
    if (!_digitRegex.hasMatch(input)) {
      return 'A number is required.';
    }
    return null;
  }

  /// Validates if the input has at least one special character.
  static String? validateHasSpecialCharacter(String input) {
    if (!_specialCharRegex.hasMatch(input)) {
      return 'A special character (@\$!%*?&) is required.';
    }
    return null;
  }

  /// Validates if the input meets a minimum length.
  static String? validateMinLength(String input, int minLength) {
    if (input.length < minLength) {
      return 'Must be at least $minLength characters long.';
    }
    return null;
  }

  /// Validates a name field.
  /// Checks for emptiness and minimum length.
  static String? validateName(String? name, String fieldName) {
    if (name == null || name.isEmpty) {
      return '$fieldName cannot be empty.';
    }
    if (name.length < 3) {
      return '$fieldName must be at least 3 characters long.';
    }
    return null; // Return null if validation is successful
  }
}

class AppUtil {
  static String? isValidEmail(String email) {
    if (email.isEmpty) {
      return 'Email can\'t be empty.';
    }
    String pattern = r'\w+@\w+\.\w+';

    if (!RegExp(pattern).hasMatch(email)) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  static String? isValidPassword(String password) {
    RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9])(?!.*\s).{8,16}$');

    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 8 || password.length > 16) {
      return 'Length between 8-16 characters';
    }
    if (!passwordRegex.hasMatch(password)) {
      return 'Password is not strong enough';
    }
    return null;
  }

  static bool checkEmail(String email) {
    String pattern = r'\w+@\w+\.\w+';
    return RegExp(pattern).hasMatch(email);
  }

  static bool checkPassword(String password) {
    RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9])(?!.*\s).{8,16}$');
    return passwordRegex.hasMatch(password);
  }
}

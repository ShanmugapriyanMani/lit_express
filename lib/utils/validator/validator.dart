class TValidator {

  static String? validateMobileNo(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile No is required.";
    }
    final mobileNumberRegex = RegExp(r'^[1-9]\d{9}$');

    if (!mobileNumberRegex.hasMatch(value)) {
      return 'Invalid mobile No.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    return null;
  }
}
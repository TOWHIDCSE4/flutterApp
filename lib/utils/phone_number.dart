class PhoneNumberValid {
  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Hãy nhập số điện thoại';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }
}
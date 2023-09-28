class ValidText {
  static String? validPass(String pass) {
    var numRegex = RegExp(r".*[0-9].*");
    var alphaRegex = RegExp(r".*[a-zA-Z].*");

    if (numRegex.hasMatch(pass) && alphaRegex.hasMatch(pass) && pass.length >= 6) {
      return null;
    }
    return "Mật khẩu phải từ 6 ký tự trở lên và gồm cả chữ và số ";
  }
}

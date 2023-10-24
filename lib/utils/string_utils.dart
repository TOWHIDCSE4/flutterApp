import 'package:intl/intl.dart';

import 'date_utils.dart';

class SahaStringUtils {
  static final SahaStringUtils _singleton = SahaStringUtils._internal();

  SahaStringUtils._internal();

  factory SahaStringUtils() {
    return _singleton;
  }

  String displayTimeAgoFromTime(DateTime time) {
    final int diffInHours = DateTime.now().difference(time.toLocal()).inHours;
    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(time.toLocal()).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'phút';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'giờ';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'ngày';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'tuần';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'tháng';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'năm';
    }

    timeAgo = '$timeValue $timeUnit';
    if (timeAgo == "0 phút") return 'Đang hoạt động';
    return '$timeAgo trước';
  }

  String convertAddress(String address) {
    return address
        .replaceAll("Thành phố", "")
        .replaceAll("Thành Phố", "")
        .replaceAll("Tỉnh", "")
        .replaceAll("Quận", "")
        .replaceAll("Huyện", "");
  }

  String convertToMoney(dynamic price) {
    if (price is String) {
      price = double.parse(price);
    }
    return CURRENCY_FORMAT.format(price); // + "đ";
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  String convertFormatText(dynamic text) {
    if (text is String) {
      text = text.replaceAll(',', '');
    }
    return text;
  }

  String convertToUnit(dynamic value) {
    if (value is String) {
      value = double.parse(value);
    }
    return UNIT_FORMAT.format(value); // + "đ";
  }

  String removeSeparateInString(String value) {
    return value.replaceAll(',', '');
  }

  String convertToDetailItem(
      double timeStart, double timeServing, String text) {
    return "${SahaDateUtils().getTimeByMinute(timeStart)} - ${SahaDateUtils().getTimeByMinute(timeStart + timeServing)}  $text\n$text";
  }

  num convertThousandToNumber(String price) {
    price = price.replaceAll(',', '');
    try {
      return num.parse(price);
    } catch (error) {
      return 0;
    }
  }

  String convertToK(dynamic price) {
    try {
      if (price is String) {
        price = double.parse(price);
      }
      price = price / 1000;
      return "${(double.parse(price.toString())).toStringAsFixed(0)}k";
    } catch (e) {
      print(e);
      return price.toString();
    }
  }

  double getReverseValue(String value, bool isIgnore) {
    if (isIgnore) {
      return double.parse(value);
    }
    try {
      return double.parse(value) * -1;
    } catch (e) {
      return 0;
    }
  }

  String? removeDecimalIfNeeded(dynamic value, {int decimal = 1}) {
    if (value is String) {
      try {
        value = double.parse(value);
      } catch (e) {
        return value;
      }
    }
    if (value is double) {
      if (value % 1 == 0) {
        return value.toInt().toString();
      }
      return value.toStringAsFixed(decimal);
    }
    return null;
  }

  bool isNotEmpty(dynamic item) {
    if (item == null) return false;
    if (item is String) {
      return item.isNotEmpty;
    }
    return false;
  }

  bool isEmpty(String s) {
    return !isNotEmpty(s);
  }

  final CURRENCY_FORMAT = NumberFormat('#,##0', 'ID');

  final UNIT_FORMAT = NumberFormat("#,##0", "en_US");

  String getAssetPath(String asset) {
    return "assets/$asset";
  }

  String removeLeading(String pattern, String from) {
    int i = 0;
    while (pattern == from[i]) {
      i++;
      if (i == from.length) break;
    }
    if (i == from.length) {
      return "0";
    } else {
      return from.substring(i, from.length);
    }
  }

  bool validateCharacter(String value) {
    var validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
    if (validCharacters.hasMatch(value) == true) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  String convertBankName(String? bankCode) {
    switch (bankCode) {
      case 'BIDV':
        return 'Ngân hàng TMCP Đầu tư và Phát triển Việt Nam(BIDV)';
      case 'VCB':
        return 'Ngân hàng TMCP Ngoại thương Việt Nam(Vietcombank)';
      case 'TCB':
        return 'Ngân hàng TMCP Kỹ thương Việt Nam(Techcombank)';
      case 'MB':
        return 'Ngân hàng TMCP Quân Đội(MBBank)';
      case 'AGRIBANK':
        return 'Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam(Agribank)';
      default:
        return '';
    }
  }
}

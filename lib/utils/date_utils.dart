import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SahaDateUtils {
  static final SahaDateUtils _singleton = SahaDateUtils._internal();

  var formatYYMMDD = DateFormat('yyyy-MM-dd');
  var formatYMD = DateFormat('dd-MM-yyyy');
  var formatYMD_HHMMSS = DateFormat('yyyy-MM-dd HH:mm:ss');
  var formatYMD_HHMM = DateFormat('yyyy-MM-dd HH:mm');
  var formatDMY = DateFormat('dd-MM-yyyy');
  var formatDMY4 = DateFormat('dd/MM/yyyy');
  var formatDMY2 = DateFormat('dd/M/yy');
  var formatDMY3 = DateFormat('dd-MM-yyyy HH:mm');
  var formatHHmm = DateFormat('HH:mm');
  var formatddMM = DateFormat('dd/MM');
  var formatMMyyyy = DateFormat('MM/yyyy');
  var formatMyyyy = DateFormat('M/yyyy');
  var formatHDM = DateFormat('hh:mm, dd-MM');

  SahaDateUtils._internal();

  factory SahaDateUtils() {
    return _singleton;
  }

  DateTime getDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String convertDateToWeekDate(DateTime dateTime) {
    if (dateTime.weekday == 1) {
      return "Thứ Hai";
    } else if (dateTime.weekday == 2) {
      return "Thứ Ba";
    } else if (dateTime.weekday == 3) {
      return "Thứ Tư";
    } else if (dateTime.weekday == 4) {
      return "Thứ Năm";
    } else if (dateTime.weekday == 5) {
      return "Thứ Sáu";
    } else if (dateTime.weekday == 6) {
      return "Thứ Bảy";
    } else if (dateTime.weekday == 7) {
      return "Chủ Nhật";
    } else {
      return "";
    }
  }

  String convertDateToWeekDate2(DateTime dateTime) {
    if (dateTime.weekday == 1) {
      return "T2";
    } else if (dateTime.weekday == 2) {
      return "T3";
    } else if (dateTime.weekday == 3) {
      return "T4";
    } else if (dateTime.weekday == 4) {
      return "T5";
    } else if (dateTime.weekday == 5) {
      return "T6";
    } else if (dateTime.weekday == 6) {
      return "T7";
    } else if (dateTime.weekday == 7) {
      return "CN";
    } else {
      return "";
    }
  }

  String textDateTimeKeeping(int date) {
    if (date == 2) return "Thứ Hai";
    if (date == 3) return "Thứ Ba";
    if (date == 4) return "Thứ Tư";
    if (date == 5) return "Thứ Năm";
    if (date == 6) return "Thứ Sáu";
    if (date == 7) return "Thứ Bảy";
    if (date == 8) return "Chủ nhật";
    return "";
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  String getStringTimeSpa(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatHDM.format(dateTime.toLocal());
  }

  String getStringMYYYYFromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatMyyyy.format(dateTime.toLocal());
  }

  String getStringMYYYYFromDateTime(DateTime date) {
    return formatMyyyy.format(date.toLocal());
  }

  String getStringMMyyyyFromDateTime(DateTime dateTime) {
    return formatMMyyyy.format(dateTime.toLocal());
  }

  String getStringddMMFromDateTime(DateTime dateTime) {
    return formatddMM.format(dateTime.toLocal());
  }

  String getStringddMMFromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatddMM.format(dateTime.toLocal());
  }

  DateTime getDateTimeFormString(String date) {
    return formatYMD_HHMMSS.parse(date);
  }

  // DateTime getDateTFromDateTime(String dateTime) {
  //   return formatMMyyyy.parse(dateTime);
  // }

  DateTime getUtcDateTimeFormString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return DateTime.utc(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );
  }

  String getStringHHmmFormString(String date) {
    var dateTime = getDateTimeFormString(date);
    return formatHHmm.format(dateTime.toLocal());
  }

  String getStringHHmmFromDateTime(DateTime dateTime) {
    return formatHHmm.format(dateTime.toLocal());
  }

  String getToDayString() {
    return formatYMD.format(DateTime.now().toLocal());
  }

  String getDateTimeString() {
    return formatYMD_HHMMSS.format(DateTime.now().toLocal());
  }

  DateTime getDateTimePlusMinuteString(DateTime dateTime, int minute) {
    return dateTime.add(Duration(minutes: minute));
  }

  DateTime getDateTimeNowPlusMinuteString(int minute) {
    return DateTime.now().add(Duration(minutes: minute));
  }

  String getDateTimeString2(DateTime dateTime) {
    return formatYMD_HHMMSS.format(dateTime.toLocal());
  }

  String getDateTimeString3(DateTime dateTime) {
    return formatYMD_HHMM.format(dateTime.toLocal());
  }

  String getDateByFormat(DateTime date) {
    return formatYMD.format(date.toLocal());
  }

  String getYYMMDD(DateTime dateTime) {
    return formatYYMMDD.format(dateTime.toLocal());
  }

  String getDDMMYY(DateTime dateTime) {
    return formatDMY.format(dateTime.toLocal());
  }

  String getDDMMYY4(DateTime dateTime) {
    return formatDMY4.format(dateTime.toLocal());
  }

  String getDDMM(DateTime dateTime) {
    return formatddMM.format(dateTime.toLocal());
  }

  String getDDMMYYFromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatDMY.format(dateTime.toLocal());
  }

  String getDDMMYY2FromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatDMY2.format(dateTime.toLocal());
  }

  String getDDMMYY2(DateTime dateTime) {
    return formatDMY2.format(dateTime.toLocal());
  }

  String getDDMMYY3(DateTime dateTime) {
    return formatDMY3.format(dateTime.toLocal());
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  int dayOfYear(DateTime date) {
    return int.parse(DateFormat('D').format(date.toLocal()));
  }

  int weekOfYear(DateTime date) {
    return ((dayOfYear(date) - date.weekday + 10) / 7).floor();
  }

  int getTimeStartMilisecond(String time) {
    DateTime dateTime = DateTime.parse(time);

    return dateTime.millisecondsSinceEpoch;
  }

  double getMinuteInDay(String time) {
    DateTime dateTime = DateTime.parse(time);
    return (dateTime.hour * 60 + dateTime.minute).toDouble();
  }

  String getTimeByMinute(double minutes) {
    String hour =
        (minutes ~/ 60 < 10) ? '0${minutes ~/ 60}' : '${minutes ~/ 60}';
    String minute = ((minutes % 60).toInt() < 10)
        ? '0${(minutes % 60).toInt()}'
        : '${(minutes % 60).toInt()}';
    return '$hour:$minute';
  }

  int getDateOfTheMonth(String time) {
    DateTime dateTime = DateTime.parse(time);
    return dateTime.day;
  }

  int getMonthFromString(String time) {
    DateTime dateTime = DateTime.parse(time);
    return dateTime.month;
  }

  String getYesterday() {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    return formatYMD.format(yesterday.toLocal());
  }

  DateTime getYesterdayDATETIME() {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    return yesterday;
  }

  String getStringEndOfTheDay(DateTime dateTime) {
    DateTime endDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59);
    return getDateTimeString2(endDate);
  }

  String getStringBeginOfTheDay(DateTime dateTime) {
    DateTime endDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00);
    return getDateTimeString2(endDate);
  }

  DateTime getEndOfTheDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59);
  }

  DateTime getBeginOfTheDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00);
  }

  String getFirstDayOfWeek() {
    DateTime now = DateTime.now();
    DateTime firstDayOfWeek = DateTime(
        now.year, now.month, now.day - now.weekday + 1); //tinh thu 2
    return formatYMD.format(firstDayOfWeek);
  }

  DateTime getFirstDayOfWeekDATETIME() {
    DateTime now = DateTime.now();
    DateTime firstDayOfWeek = DateTime(
        now.year, now.month, now.day - now.weekday + 1); //tinh thu 2
    return firstDayOfWeek;
  }

  String getEndDayOfWeek() {
    DateTime now = DateTime.now();
    DateTime endDayOfWeek =
        DateTime(now.year, now.month, now.day + (7 - now.weekday));
    return formatYMD.format(endDayOfWeek.toLocal());
  }

  DateTime getEndDayOfWeekDATETIME() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day + (7 - now.weekday));
  }

  String getFirstDayOfLastWeek() {
    DateTime now = DateTime.now();
    DateTime firtDayOfWeek =
        DateTime(now.year, now.month, now.day - now.weekday + 1 - 7);
    return formatYMD.format(firtDayOfWeek.toLocal());
  }

  DateTime getFirstDayOfLastWeekDATETIME() {
    DateTime now = DateTime.now();
    DateTime firtDayOfWeek =
        DateTime(now.year, now.month, now.day - now.weekday + 1 - 7);
    return firtDayOfWeek;
  }

  String getEndDayOfLastWeek() {
    DateTime now = DateTime.now();
    DateTime endDayOfWeek =
        DateTime(now.year, now.month, now.day + (7 - now.weekday) - 7);
    return formatYMD.format(endDayOfWeek.toLocal());
  }

  DateTime getEndDayOfLastWeekDATETIME() {
    DateTime now = DateTime.now();
    DateTime endDayOfWeek =
        DateTime(now.year, now.month, now.day + (7 - now.weekday) - 7);
    return endDayOfWeek;
  }

  String getFirstDayOfMonth() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, now.month, 1);
    return formatYMD.format(first.toLocal());
  }

  DateTime getFirstDayOfMonthDATETIME() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, now.month, 1);
    return first;
  }

  DateTime getFirstDayOfMonthDateTime() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, now.month, 1);
    return first;
  }

  String getEndDayOfMonth() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, now.month + 1, 0);
    return formatYMD.format(end.toLocal());
  }

  DateTime getEndDayOfMonthDateTime() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, now.month + 1, 0);
    return end;
  }

  String getFirstDayOfLastMonth() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, now.month - 1, 1);
    return formatYMD.format(first.toLocal());
  }

  DateTime getFirstDayOfLastMonthDATETIME() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, now.month - 1, 1);
    return first;
  }

  String getEndDayOfLastMonth() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, now.month, 0);
    return formatYMD.format(end.toLocal());
  }

  DateTime getEndDayOfLastMonthDATETIME() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, now.month, 0);
    return end;
  }

  String getFirstDayOfThisQuarter() {
    DateTime now = DateTime.now();
    DateTime first;
    if (now.month < 4) {
      first = DateTime(now.year, 1, 1);
    } else if (now.month < 7) {
      first = DateTime(now.year, 4, 1);
    } else if (now.month < 10) {
      first = DateTime(now.year, 7, 1);
    } else {
      first = DateTime(now.year, 10, 1);
    }
    return formatYMD.format(first.toLocal());
  }

  String getEndDayOfThisQuarter() {
    DateTime now = DateTime.now();
    DateTime end;
    if (now.month < 4) {
      end = DateTime(now.year, 4, 0);
    } else if (now.month < 7) {
      end = DateTime(now.year, 7, 0);
    } else if (now.month < 10) {
      end = DateTime(now.year, 10, 0);
    } else {
      end = DateTime(now.year + 1, 1, 0);
    }
    return formatYMD.format(end.toLocal());
  }

  String getFirstDayOfLastQuarter() {
    DateTime now = DateTime.now();
    DateTime first;
    if (now.month < 4) {
      first = DateTime(now.year, 10, 1);
    } else if (now.month < 7) {
      first = DateTime(now.year, 1, 1);
    } else if (now.month < 10) {
      first = DateTime(now.year, 4, 1);
    } else {
      first = DateTime(now.year, 7, 1);
    }
    return formatYMD.format(first.toLocal());
  }

  String getEndDayOfLastQuarter() {
    DateTime now = DateTime.now();
    DateTime end;
    if (now.month < 4) {
      end = DateTime(now.year + 1, 1, 0);
    } else if (now.month < 7) {
      end = DateTime(now.year, 4, 0);
    } else if (now.month < 10) {
      end = DateTime(now.year, 7, 0);
    } else {
      end = DateTime(now.year, 10, 0);
    }
    return formatYMD.format(end.toLocal());
  }

  String getFirstDayOfThisYear() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, 1, 1);
    return formatYMD.format(first.toLocal());
  }

  DateTime getFirstDayOfThisYearDATETIME() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, 1, 1);
    return first;
  }

  String getEndDayOfThisYear() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year + 1, 1, 0);
    return formatYMD.format(end.toLocal());
  }

  DateTime getEndDayOfThisYearDATETIME() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year + 1, 1, 0);
    return end;
  }

  String getFirstDayOfLastYear() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year - 1, 1, 1);
    return formatYMD.format(first.toLocal());
  }

  DateTime getFirstDayOfLastYearDATETIME() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year - 1, 1, 1);
    return first;
  }

  String getEndDayOfLastYear() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, 1, 0);
    return formatYMD.format(end.toLocal());
  }

  DateTime getEndDayOfLastYearDATETIME() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, 1, 0);
    return end;
  }

  String getDMH(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return getDMHfromDateTime(dateTime);
  }

  String getDMHfromDateTime(DateTime dateTime) {
    return DateFormat('MM-dd HH:mm').format(dateTime.toLocal());
  }

  String getDMHfromString(String dateTime) {
    DateTime date = DateTime.now();
    if (dateTime.isNotEmpty) {
      date = DateTime.parse(dateTime);
    }
    return getDMHfromDateTime(date);
  }

  String gethhmmss(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime.toLocal());
  }

  String getHHMMSS(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime.toLocal());
  }

  String secondsToHours(int seconds) {
    seconds = seconds.abs();
    var minute = Duration(
            seconds: seconds - (Duration(seconds: seconds).inHours * 60 * 60))
        .inMinutes;
    var second = Duration(
            seconds: seconds -
                ((Duration(seconds: seconds).inHours * 60 * 60 + minute * 60)))
        .inSeconds;
    return "${Duration(seconds: seconds).inHours} giờ ${Duration(seconds: seconds - (Duration(seconds: seconds).inHours * 60 * 60)).inMinutes} phút ${second}s";
  }

  String getHHMM(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime.toLocal());
  }

  Future<TimeOfDay?> selectTime(
      BuildContext context, TimeOfDay initTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != initTime) {
      return picked;
    }
    return null;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}

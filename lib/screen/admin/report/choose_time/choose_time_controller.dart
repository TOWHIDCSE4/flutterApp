import 'package:get/get.dart';

import '../../../../utils/date_utils.dart';

class ChooseTimeController extends GetxController {
  DateTime? timeNow;
  bool checkSelected = false;
  bool checkSelectedCP = false;
  List<String> listTextChooseDAY = ["Hôm nay: ", "Hôm qua: "];
  List<DateTime>? listFromDateDAY;
  List<DateTime>? listToDateDAY;
  List<String> listTextChooseWEEK = [
    "Tuần này: ",
    "7 ngày qua: ",
    "Tuần trước: "
  ];
  List<DateTime>? listFromDateWEEK;
  List<DateTime>? listToDateWEEK;
  List<String>? listTextChooseMONTH = [
    "Tháng này: ",
    "30 ngày qua: ",
    "Tháng trước: "
  ];
  List<DateTime>? listFromDateMONTH;
  List<DateTime>? listToDateMONTH;
  List<String>? listTextChooseYEAR = ["Năm này: ", "Năm trước: "];
  List<DateTime>? listFromDateYEAR;
  List<DateTime>? listToDateYEAR;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;

  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  final DateTime? fromDayInput;
  final DateTime? toDayInput;
  final DateTime? fromDayCpInput;
  final DateTime? toDayCpInput;
  int? indexChooseSave = 0;

  /// compare
  bool? isCompareInput;
  var isCompare = false.obs;
  var listFromDateDAYCP = RxList<DateTime>();
  var listToDateDAYCP = RxList<DateTime>();
  var listFromDateWEEKCP = RxList<DateTime>();
  var listToDateWEEKCP = RxList<DateTime>();
  var listFromDateMONTHCP = RxList<DateTime>();
  var listToDateMONTHCP = RxList<DateTime>();
  var listFromDateYEARCP = RxList<DateTime>();
  var listToDateYEARCP = RxList<DateTime>();
  var fromDateOption = DateTime.now().obs;
  var toDateOption = DateTime.now().obs;
  var fromDateOptionCP = DateTime.now().obs;
  var toDateOptionCP = DateTime.now().obs;

  List<String> listTextChooseDAYCP = [
    "Ngày trước đó: ",
    "Ngày này tuần trước: ",
    'Ngày này năm trước: '
  ];

  List<String> listTextChooseWEEKCP = [
    "Tuần trước đó: ",
    "Tuần này tháng trước: ",
  ];

  List<String> listTextChooseMONTHCP = [
    "Tháng trước đó: ",
    "Tháng này năm trước: ",
  ];

  List<String> listTextChooseYEARCP = [
    "Năm trước đó: ",
  ];

  DateTime getDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  ChooseTimeController(
      {this.isCompareInput,
      this.fromDayInput,
      this.toDayInput,
      this.fromDayCpInput,
      this.toDayCpInput}) {
    isCompare.value = isCompareInput!;

    timeNow = DateTime.now();

    listFromDateDAY = [
      getDate(timeNow!),
      SahaDateUtils().getYesterdayDATETIME(),
    ];
    listToDateDAY = [
      getDate(timeNow!),
      SahaDateUtils().getYesterdayDATETIME(),
    ];
    listFromDateWEEK = [
      SahaDateUtils().getFirstDayOfWeekDATETIME(),
      getDate(DateTime.now()).subtract(const Duration(days: 7)),
      SahaDateUtils().getFirstDayOfLastWeekDATETIME(),
    ];
    listToDateWEEK = [
      getDate(timeNow!),
      getDate(timeNow!),
      SahaDateUtils().getEndDayOfLastWeekDATETIME(),
    ];
    listFromDateMONTH = [
      SahaDateUtils().getFirstDayOfMonthDATETIME(),
      getDate(DateTime.now()).subtract(const Duration(days: 30)),
      SahaDateUtils().getFirstDayOfLastMonthDATETIME(),
    ];
    print(listFromDateMONTH);
    listToDateMONTH = [
      getDate(timeNow!),
      getDate(timeNow!),
      SahaDateUtils().getEndDayOfLastMonthDATETIME(),
    ];
    print(listToDateMONTH);
    listFromDateYEAR = [
      SahaDateUtils().getFirstDayOfThisYearDATETIME(),
      SahaDateUtils().getFirstDayOfLastYearDATETIME(),
    ];
    listToDateYEAR = [
      getDate(timeNow!),
      SahaDateUtils().getEndDayOfLastYearDATETIME(),
    ];

    /// compare
    listFromDateDAYCP([
      SahaDateUtils().getYesterdayDATETIME(),
      SahaDateUtils().getYesterdayDATETIME().subtract(const Duration(days: 6)),
      getDate(timeNow!).subtract(const Duration(days: 365)),
    ]);

    listToDateDAYCP([
      SahaDateUtils().getYesterdayDATETIME(),
      SahaDateUtils().getYesterdayDATETIME().subtract(const Duration(days: 6)),
      getDate(timeNow!).subtract(const Duration(days: 365)),
    ]);

    listFromDateWEEKCP([
      SahaDateUtils().getFirstDayOfLastWeekDATETIME(),
      SahaDateUtils().getFirstDayOfWeekDATETIME().subtract(const Duration(days: 31)),
    ]);

    listToDateWEEKCP([
      SahaDateUtils().getEndDayOfLastWeekDATETIME(),
      getDate(timeNow!).subtract(const Duration(days: 31)),
    ]);

    listFromDateMONTHCP([
      SahaDateUtils().getFirstDayOfLastMonthDATETIME(),
      SahaDateUtils().getFirstDayOfMonthDATETIME().subtract(const Duration(days: 365))
    ]);

    listToDateMONTHCP([
      getDate(timeNow!).subtract(const Duration(days: 31)),
      getDate(timeNow!).subtract(const Duration(days: 365)),
    ]);

    listFromDateYEARCP([
      SahaDateUtils().getFirstDayOfLastYearDATETIME(),
    ]);

    listToDateYEARCP([
      getDate(timeNow!).subtract(const Duration(days: 366)),
    ]);

    fromDateOption.value = getDate(fromDayInput ?? timeNow!);
    toDateOption.value = getDate(toDayInput ?? timeNow!);
    fromDateOptionCP.value = getDate(fromDayCpInput ?? timeNow!);
    toDateOptionCP.value = getDate(toDayCpInput ?? timeNow!);
  }

  void chooseDate(
      DateTime fromDate, DateTime toDate, int indexType, int indexChoose) {
    checkSelected = true;
    fromDay.value = DateTime(fromDate.year, fromDate.month, fromDate.day);
    toDay.value = DateTime(toDate.year, toDate.month, toDate.day);
    indexChooseSave = indexChoose;
    if (indexType == 0) {
      listFromDateDAYCP([
        fromDay.value.subtract(const Duration(days: 1)),
        fromDay.value.subtract(const Duration(days: 6)),
        fromDay.value.subtract(const Duration(days: 365)),
      ]);
      listToDateDAYCP([
        toDay.value.subtract(const Duration(days: 1)),
        toDay.value.subtract(const Duration(days: 6)),
        toDay.value.subtract(const Duration(days: 365)),
      ]);
    }
    if (indexType == 1) {
      listFromDateWEEKCP([
        fromDay.value.subtract(const Duration(days: 7)),
        fromDay.value.subtract(const Duration(days: 31)),
      ]);
      listToDateWEEKCP([
        toDay.value.subtract(const Duration(days: 7)),
        toDay.value.subtract(const Duration(days: 31)),
      ]);
    }
    if (indexType == 2) {
      listFromDateMONTHCP([
        fromDay.value.subtract(const Duration(days: 31)),
        fromDay.value.subtract(const Duration(days: 365)),
      ]);
      listToDateMONTHCP([
        toDay.value.subtract(const Duration(days: 31)),
        toDay.value.subtract(const Duration(days: 365)),
      ]);
    }
    if (indexType == 3) {
      listFromDateYEARCP([
        fromDay.value.subtract(const Duration(days: 365)),
      ]);
      listToDateYEARCP([
        toDay.value.subtract(const Duration(days: 366)),
      ]);
    }
  }

  void chooseDateCP(
    DateTime fromDate,
    DateTime toDate,
  ) {
    checkSelectedCP = true;
    fromDayCP.value = fromDate;
    toDayCP.value = toDate;
  }

  void onOkChooseTime(DateTime startDate, DateTime endDate) {
    checkSelected = true;
    fromDay.value = startDate;
    toDay.value = endDate;
    fromDateOption.value = startDate;
    toDateOption.value = endDate;
    Get.back();
  }

  void onOkChooseTimeCP(DateTime startDate, DateTime endDate) {
    checkSelectedCP = true;
    fromDayCP.value = startDate;
    toDayCP.value = endDate;
    fromDateOptionCP.value = startDate;
    toDateOptionCP.value = endDate;
    Get.back();
  }

  void autoChoose(int index) {
    if (index == 0) {
      fromDay.value = listFromDateDAY![index];
      toDay.value = listToDateDAY![index];
      checkSelected = true;
    } else if (index == 1) {
      fromDay.value = listFromDateWEEK![0];
      toDay.value = listToDateWEEK![0];
      checkSelected = true;
    } else if (index == 2) {
      fromDay.value = listFromDateMONTH![0];
      toDay.value = listToDateMONTH![0];
      checkSelected = true;
    } else if (index == 3) {
      fromDay.value = listFromDateYEAR![0];
      toDay.value = listToDateYEAR![0];
      checkSelected = true;
    } else if (index == 4) {}
  }
}

import 'package:gohomy/data/remote/response-request/report/overview_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_users_did_kyc.dart';
import 'package:gohomy/data/remote/response-request/report/summary_motel_res.dart';
import 'package:intl/intl.dart';
import '../../remote/response-request/admin_manage/report_post_find_room_res.dart';
import '../../remote/response-request/report/report_commission_res.dart';
import '../../remote/response-request/report/report_find_fast_motel_res.dart';
import '../../remote/response-request/report/report_motel_res.dart';
import '../../remote/response-request/report/report_order_res.dart';
import '../../remote/response-request/report/report_post_badge_res.dart';
import '../../remote/response-request/report/report_post_find_room_res.dart';
import '../../remote/response-request/report/report_post_res.dart';
import '../../remote/response-request/report/report_post_roommate_res.dart';
import '../../remote/response-request/report/report_potential_to_renter_res.dart';
import '../../remote/response-request/report/report_renter_has_motel_res.dart';
import '../../remote/response-request/report/report_renter_res.dart';
import '../../remote/response-request/report/report_reservation_motels_res.dart';
import '../../remote/response-request/report/report_service_sell_res.dart';
import '../../remote/response-request/report/report_static_bill_res.dart';
import '../../remote/response-request/report/report_static_contract_res.dart';
import '../../remote/response-request/report/report_static_potential_res.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class ReportRepository {
  Future<ReportRenterRes?> getReportRenter(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportRenter(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportFindFastMotelRes?> getReportFindFastMotel(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportFindFastMotel(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportReservationMotelRes?> getReportReservationMotel(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportReservationMotel(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportMotelRes?> getReportMotel(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportMotel(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportServiceSellRes?> getServiceSellReport(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getServiceSellReport(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportPostBadgeRes?> getReportPostBadge(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportPostBadge(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportOrderRes?> getReportOrder(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportOrder(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportPostRes?> getReportPost(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportPost(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportStaticPostFindRoomRes?> getReportPostFindRoom(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportPostFindRoom(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportStaticPostRoommateRes?> getReportPostRoommate(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportPostRoommate(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportStaticPotentialRes?> getReportStaticPotential(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportStaticPotential(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportStaticContractRes?> getReportStaticContract(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportStaticContract(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportStaticBillRes?> getReportStaticBill(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportStaticBill(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

   Future<ReportPotentialToRenterRes?> getReportPotentialToRenter(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportPotentialToRenter(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<OverViewRes?> getOverView(
      {DateTime? startDate, DateTime? endDate}) async {
    try {
      var res = await SahaServiceManager().service!.getOverView(
            startDate == null ? null : DateFormat('yyyy-MM').format(startDate),
            endDate == null ? null : DateFormat('yyyy-MM').format(endDate),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SummaryMotelRes?> getSummaryMotel(
      {DateTime? startDate, DateTime? endDate}) async {
    try {
      var res = await SahaServiceManager().service!.getSummaryMotel(
            startDate == null
                ? null
                : DateFormat('yyyy-MM-dd').format(startDate),
            endDate == null ? null : DateFormat('yyyy-MM-dd').format(endDate),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  //////reprot commission
  Future<ReportCommissionRes?> getReportCommission(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportCommission(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportRenterHasMotelRes?> getReportRenterHasMotel(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportRenterHasMotel(
            timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
            timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportStaticUsersDidKycRes?> getReportStaticUsersDidKyc(
      {DateTime? timeFrom, DateTime? timeTo}) async {
    try {
      var res = await SahaServiceManager().service!.getReportUsersDidKyc(
        timeFrom == null ? null : DateFormat('yyyy-MM-dd').format(timeFrom),
        timeTo == null ? null : DateFormat('yyyy-MM-dd').format(timeTo),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

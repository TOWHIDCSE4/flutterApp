import 'package:gohomy/data/remote/saha_service_manager.dart';

import '../../remote/response-request/notification/all_notification_response.dart';
import '../../remote/response-request/success/success_response.dart';
import '../handle_error.dart';

class NotificationRepository {
  Future<AllNotificationResponse?> historyNotification(int page) async {
    try {
      var res = await SahaServiceManager().service!.historyNotification(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> readAllNotification() async {
    try {
      var res = await SahaServiceManager().service!.readAllNotification();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> readNotification({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.readNotification(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> sendDeviceToken({required String token}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendDeviceToken({"device_token": token});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

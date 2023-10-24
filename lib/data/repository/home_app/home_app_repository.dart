import '../../remote/response-request/home_app/home_app_response.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class HomeAppRepository {
  Future<HomeAppRes?> getHomeApp(int province) async {
    try {
      var res = await SahaServiceManager().service!.getHomeApp(province);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

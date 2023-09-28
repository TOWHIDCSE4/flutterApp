import 'dart:developer';

import 'package:dio/dio.dart';


import '../../../components/dialog/dialog.dart';

import '../../../utils/user_info.dart';

/// Inteceptor which used in Dio to add authentication
/// token, device code before perform any request
///
class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (UserInfo().getToken() != null) {
      options.headers.putIfAbsent("token", () => UserInfo().getToken());
    }

    print('Link: ${options.uri.toString()}');
    print('Header: ${options.headers}');
    printWrapped('Request: ${options.data}');

    var hasImage = false;
    if (options.data is Map) {
      for (var element in (options.data as Map).values) {
        if (element is MultipartFile) {
          hasImage = true;
        }
      }
    }
    if (options.method == 'POST' && hasImage) {
      options.data = FormData.fromMap(options.data);
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    print('On Error: ${error.response}');

    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          error.error = 'Đã hủy kết nối';
          break;
        case DioErrorType.connectTimeout:
          error.error = 'Không thể kết nối đến server';
          break;
        case DioErrorType.receiveTimeout:
          error.error = 'Không thể nhận dữ liệu từ server';
          break;
        case DioErrorType.response:
          if (error.response?.statusCode == 429) {
            error.error = 'Bạn gửi quá nhiều yêu cầu xin thử lại sau 1 phút';
            break;
          }
          if (error.response?.statusCode == 500) {
            error.error = 'Lỗi mạng vui lòng thử lại sau';
            log('${error.response}');
            break;
          }
          error.error =
              '${dioError.response?.data["msg"] ?? "Lỗi kết nối vui lòng kiểm tra lại mạng"}';
          break;
        case DioErrorType.sendTimeout:
          error.error = 'Không thể gửi dữ liệu đến server';
          break;
        case DioErrorType.other:
          //error.error = error.message;
          error.error = 'Lỗi mạng vui lòng thử lại sau ';
          break;
      }
    }

    return handler.next(error);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('------Response: ${response.data}');

    if (response.data["code"] == 401) {
      UserInfo().setToken(null);
      SahaDialogApp.showDialogNotificationOneButton(
          mess: "Hết phiên đăng nhập mời đăng nhập lại",
          barrierDismissible: false,
          onClose: () {
            UserInfo().logout();
          });
    }

    if (response.data != null && response.data["success"] == false) {
      throw response.data["msg"] ?? "Đã xảy ra lỗi";
    }

    if (response.data != null &&
        response.data["code"] != 200 &&
        response.data["code"] != 400 &&
        response.data["code"] != 500) {
      try {
        if (response.data["code"] == 401) {
          print("Logout");
        } else {}
      } catch (e) {
        print(e.toString());
      }
      return super.onResponse(response, handler);
    }

    return super.onResponse(response, handler);
  }
}

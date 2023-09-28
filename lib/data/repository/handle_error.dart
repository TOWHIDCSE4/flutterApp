import 'package:dio/dio.dart';

String handleError(err) {
  if (err is DioError) {
    print("ERROR Dio: ${err.error.toString()}");
    throw err.error.toString();
  } else {
    print("ERROR: ${err.toString()}");
    throw "Có lỗi xảy ra";
  }
}

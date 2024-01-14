import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Model/response_error_model.dart';
import 'package:mc_queen_cargo/features/Service/response_error.dart';

class ServiceProcess {
  static Dio dio = Dio();

  static Future<dynamic> getService(
      {required String path,
      required accessToken,
      Map<String, dynamic>? queryParameters,
      String? incoming}) async {
    var options = Options(
      headers: {"Authorization": "Bearer $accessToken"},
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
    try {
      var response = await dio.get(path,
          queryParameters: queryParameters, options: options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      ResponseErrorModel model = ResponseErrorModel();
      if (err.response != null) {
        model.statusCode = err.response?.statusCode;
        model.incoming = incoming;
      } else {
        model.statusCode = 999;
      }
      ErrorResponse.streamController.sink.add(model);
      throw Future.error(err.response?.data ?? "");
    }
  }

  static Future<dynamic> postService<T>(
      {required String path,
      required Object? data,
      Map<String, dynamic>? queryParameters,
      String? accessToken}) async {
    try {
      var options = Options(
        headers: {"Authorization": "Bearer $accessToken"},
        sendTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
      );
      var response = await dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: accessToken == null ? null : options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      ResponseErrorModel model = ResponseErrorModel();
      if (err.response != null) {
        model.statusCode = err.response?.statusCode;
      } else {
        model.statusCode = 999;
      }
      ErrorResponse.streamController.sink.add(model);
      throw Future.error(err.response?.data ?? "");
    }
  }

  static Future<dynamic> putService<T>(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      required String accessToken}) async {
    try {
      var options = Options(
        headers: {"Authorization": "Bearer $accessToken"},
        sendTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
      );
      var response = await dio.put(path,
          data: data, queryParameters: queryParameters, options: options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      ResponseErrorModel model = ResponseErrorModel();
      if (err.response != null) {
        model.statusCode = err.response?.statusCode;
      } else {
        model.statusCode = 999;
      }
      ErrorResponse.streamController.sink.add(model);
      throw Future.error(err.response?.data ?? "");
    }
  }

  static Future<dynamic> deleteService<T>(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      required String? accessToken}) async {
    try {
      var options = Options(
        headers: {"Authorization": "Bearer $accessToken"},
        sendTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
      );
      var response = await dio.delete(path,
          data: data, queryParameters: queryParameters, options: options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      ResponseErrorModel model = ResponseErrorModel();
      if (err.response != null) {
        model.statusCode = err.response?.statusCode;
      } else {
        model.statusCode = 999;
      }
      ErrorResponse.streamController.sink.add(model);
      throw Future.error(err.response?.data ?? "");
    }
  }
}

bool httpStatusController(int statusCode) {
  if (statusCode >= 200 && statusCode <= 299) {
    return true;
  } else {
    return false;
  }
}

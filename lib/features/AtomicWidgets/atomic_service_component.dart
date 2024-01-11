import 'package:dio/dio.dart';

class ServiceProcess {
  static Dio dio = Dio();

  static Future<dynamic> getService(
      {required String path,
      required accessToken,
      Map<String, dynamic>? queryParameters}) async {
    var options = Options(
      headers: {"Authorization": "Bearer $accessToken"},
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    try {
      var response = await dio.get(path,
          queryParameters: queryParameters, options: options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      } else {
        throw response.data;
      }
    } on DioException catch (err) {
      throw err.response?.statusMessage.toString() ?? "";
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
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      );
      var response = await dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: accessToken == null ? null : options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      } else {
        throw response.data;
      }
    } on DioException catch (err) {
      throw err.response?.data ?? "";
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
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      );
      var response = await dio.put(path,
          data: data, queryParameters: queryParameters, options: options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      } else {
        throw response.data;
      }
    } on DioException catch (err) {
      throw err.response?.data.toString() ?? "";
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
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      );
      var response = await dio.delete(path,
          data: data, queryParameters: queryParameters, options: options);
      if (httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      } else {
        throw response.data;
      }
    } on DioException catch (err) {
      throw err.response?.statusMessage.toString() ?? "";
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

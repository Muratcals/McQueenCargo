import 'package:dio/dio.dart';
import 'package:mc_queen_cargo/features/Model/response_error_model.dart';
import 'package:mc_queen_cargo/features/Service/response_error.dart';

class ServiceProcess {
  static final _dio = Dio();

  static Future<dynamic> getService(
      {required String path,
      required accessToken,
      Map<String, dynamic>? queryParameters,
      String? incoming}) async {
    var options = _requestOptions(accessToken);
    try {
      var response = await _dio.get(path,
          queryParameters: queryParameters, options: options);
      if (_httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      _errorController(err, incoming);
    }
  }

  static Future<dynamic> postService<T>(
      {required String path,
      required Object? data,
      Map<String, dynamic>? queryParameters,
      String? accessToken,
      String? incoming}) async {
    try {
      var options = _requestOptions(accessToken);
      var response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: accessToken == null ? null : options);
      if (_httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      _errorController(err, incoming);
    }
  }

  static Future<dynamic> putService<T>(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      required String accessToken,
      String? incoming}) async {
    try {
      var options = _requestOptions(accessToken);
      var response = await _dio.put(path,
          data: data, queryParameters: queryParameters, options: options);
      if (_httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      _errorController(err, incoming);
    }
  }

  static Future<dynamic> deleteService<T>(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      required String? accessToken,
      String? incoming}) async {
    try {
      var options = _requestOptions(accessToken);
      var response = await _dio.delete(path,
          data: data, queryParameters: queryParameters, options: options);
      if (_httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      _errorController(err, incoming);
    }
  }

  static Options _requestOptions(String? accessToken) {
    return Options(
      headers: {"Authorization": "Bearer $accessToken"},
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
  }

  static void _errorController(DioException err, String? incoming) {
    ResponseErrorModel model = ResponseErrorModel();
    if (err.response != null) {
      model.statusCode = err.response?.statusCode;
      model.incoming = incoming;
    } else {
      model.statusCode = 500;
    }
    ErrorResponse.streamController.sink.add(model);
    throw Future.error(err.response?.data ?? err.message);
  }

  static bool _httpStatusController(int statusCode) {
    if (statusCode >= 200 && statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }
}

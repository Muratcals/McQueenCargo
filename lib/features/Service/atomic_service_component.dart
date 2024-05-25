import 'package:dio/dio.dart';
import 'package:mc_queen_cargo/features/Authorazation/token.dart';
import 'package:mc_queen_cargo/features/Model/response_error_model.dart';
import 'package:mc_queen_cargo/features/Service/response_error.dart';

class ServiceProcess {
  static final _dio = Dio();

  static Future<dynamic> getService(
      {required String path,
      Map<String, dynamic>? queryParameters,
      String? incoming}) async {
    var options = _requestOptions();
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
      String? incoming}) async {
    try {
      var options = _requestOptions();
      var response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: AuthenticationToken.token == null ? null : options);
      if (_httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      throw _errorController(err, incoming);
    }
  }

  static Future<dynamic> putService<T>(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      String? incoming}) async {
    try {
      var options = _requestOptions();
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
      String? incoming}) async {
    try {
      var options = _requestOptions();
      var response = await _dio.delete(path,
          data: data, queryParameters: queryParameters, options: options);
      if (_httpStatusController(response.statusCode!)) {
        return Future.value(response.data);
      }
    } on DioException catch (err) {
      _errorController(err, incoming);
    }
  }

  static Options _requestOptions() {
    return Options(
      headers: {"Authorization": "Bearer ${AuthenticationToken.token}"},
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
  }

  static Future<Error> _errorController(DioException err, String? incoming) {
    ResponseErrorModel model = ResponseErrorModel();
    if (err.response != null) {
      model.statusCode = err.response?.statusCode;
      model.statusMessage = err.response?.data["Message"] ?? err.message;
      model.incoming = incoming;
    } else {
      model.statusCode = 500;
    }
    ErrorResponse.streamController.sink.add(model);
    return Future.error(err.response?.data["Message"] ?? err.message);
  }

  static bool _httpStatusController(int statusCode) {
    if (statusCode >= 200 && statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }
}

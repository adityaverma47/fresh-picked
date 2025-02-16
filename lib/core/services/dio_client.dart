import 'package:dio/dio.dart';
import '../utils/request_interceptor.dart';
import 'api_constants.dart';

class DioClient {
  final Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;
  final RequestInterceptor requestInterceptor = RequestInterceptor();

  BaseOptions baseOptions() {
    BaseOptions options = BaseOptions();
    options.baseUrl = baseUrl;
    return options;

  }

  Dio getDio() {
    dio.options = baseOptions();
    dio.interceptors.add(requestInterceptor);
    return dio;
  }
}

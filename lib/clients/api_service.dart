import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  Dio get instance => _dio;

  ApiService(this._dio);
}

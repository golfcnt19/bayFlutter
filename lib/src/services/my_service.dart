import 'dart:convert';

import 'package:bay_flutter1/src/models/product.dart';
import 'package:dio/dio.dart';

import '../constants/network_api.dart';

class MyService {
  MyService._internal(); // SomeService();

  static final MyService _instance = MyService._internal();

  factory MyService() => _instance;

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = NetworkAPI.baseURL;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // await Future.delayed(Duration(seconds: 10));
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          switch (e.response?.statusCode) {
            case 301:
              break;
            case 401:
              break;
            default:
          }
          return handler.next(e);
        },
      ),
    );

  // http interceptor
  Future<List<Product>> feed() async {
    try {
      final response = await _dio.get("/products");
      final result = productFromJson(jsonEncode(response.data));
      return result;
    } catch (e) {
      return [];
    }
  }
}

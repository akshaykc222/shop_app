import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/core/pretty_printer.dart';

import '../shop/data/routes/app_remote_routes.dart';
import 'custom_exception.dart';

class ApiProvider {
  late Dio _dio;

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        headers: {
          "access-control-allow-origin": "*",
          // "Access-Control-Allow-Origin": "*",
          // "Access-Control-Allow-Credentials": false,
          'Content-Type': 'application/json'
        },
        baseUrl: AppRemoteRoutes.baseUrl,
        connectTimeout: 50000,
        receiveTimeout: 50000,
      ),
    );
    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Future<Map<String, dynamic>> get(String endPoint) async {
    try {
      // GetStorage sr = GetStorage();
      // String? token = sr.read('token');
      // print(token);
      // _dio.options.headers.addAll({'Authorization': 'Token $token'});
      final Response response = await _dio.get(
        endPoint,
      );

      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on DioError catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      return {};
    }
  }

  Future<Map<String, dynamic>> post(
      String endPoint, Map<String, dynamic> body) async {
    prettyPrint("on post call$body");
    try {
      prettyPrint("starting dio");

      // String? token = sr.read('token');
      // prettyPrint(msg: token ?? "");
      // if (token != null) {
      //   _dio.options.headers.addAll({'Authorization': 'Token $token'});
      // }

      final Response response = await _dio.post(
        endPoint,
        data: body,
      );

      prettyPrint("getting response$response");
      final Map<String, dynamic> responseData = classifyResponse(response);
      prettyPrint(responseData.toString());
      return responseData;
    } on DioError catch (err) {
      prettyPrint(err.toString());
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> put(
      String endPoint, Map<String, dynamic> body) async {
    prettyPrint("on post call");
    try {
      // GetStorage sr = GetStorage();
      // String? token = sr.read('token');
      // prettyPrint(msg: token ?? "");
      // _dio.options.headers.addAll({'Authorization': 'Token $token'});
      // prettyPrint(msg: "starting dio");
      final Response response = await _dio.put(
        endPoint,
        data: body,
      );

      final Map<String, dynamic> responseData = classifyResponse(response);

      return responseData;
    } on DioError catch (err) {
      prettyPrint(err.message, type: PrettyPrinterTypes.error);
      throw FetchDataException("internetError");
    }
  }

  // Future<Uint8List> download({required String imageUrl}) async {
  //   final tempStorage = await getTemporaryDirectory();
  //   final data = await _dio.download(imageUrl, tempStorage.path);
  //   final d = data.data;
  // }

  Map<String, dynamic> classifyResponse(Response response) {
    // print(response);
    final Map<String, dynamic> responseData =
        response.data as Map<String, dynamic>;

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(responseData.toString());
      case 401:
        throw UnauthorisedException(responseData.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}

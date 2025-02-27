import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:kalpas/kalpas/core/pretty_printer.dart';

import '../data/remotes_routes/app_remotes.dart';
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
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
      ),
    );
    if (!kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Future<dynamic> get(String endPoint) async {
    try {
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.get(
        endPoint,
      );
      prettyPrint("request url : ${response.realUri}");
      final responseData = classifyResponse(response);

      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      throw BadRequestException();
    }
  }

  Future<dynamic> delete(String endPoint) async {
    try {
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.delete(
        endPoint,
      );
      prettyPrint("getting response${response.realUri}");
      final responseData = classifyResponse(response);
      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      return {};
    }
  }

  Future<dynamic> post(
    String endPoint,
    dynamic body,
  ) async {
    prettyPrint("on post call$body");
    try {
      prettyPrint("starting dio");

      // prettyPrint(_dio.options.)
      final Response response = await _dio.post(
        endPoint,
        data: body,
      );

      prettyPrint("getting response${response.realUri}");
      final responseData = classifyResponse(response);
      prettyPrint(responseData.toString());
      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString());
      throw FetchDataException("Internet Error");
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    prettyPrint("on post call");
    try {
      final Response response = await _dio.put(
        endPoint,
        data: body,
      );

      final responseData = classifyResponse(response);

      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.message, type: PrettyPrinterTypes.error);
      throw FetchDataException("internetError");
    }
  }

  // Future<Uint8List> download({required String imageUrl}) async {
  //   final tempStorage = await getTemporaryDirectory();
  //   final data = await _dio.download(imageUrl, tempStorage.path);
  //   final d = data.data;
  // }

  // Map<String, dynamic> classifyResponse(Response response) {
  dynamic classifyResponse(Response response) {
    if (kDebugMode) {
      print(response);
    }
    // try {
    // final responseData =
    final responseData =
        // response.data as Map<String, dynamic>;
        response.data;
    String errorMsg = "";
    try {
      // errorMsg=responseData["error"][""]
      var error = responseData["errors"];
      var allErrors = error!.map((item) => item["message"]);
      String errorString = "";
      for (var i in allErrors) {
        errorString = "$errorString$i,";
      }
    } catch (e) {
      errorMsg = responseData.toString();
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(errorMsg);
      case 404:
        throw BadRequestException(errorMsg);
      case 401:
        throw UnauthorisedException(errorMsg);
      case 403:
        throw UnauthorisedException(errorMsg);
      case 409:
        throw DeleteConflictException(errorMsg);
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
    // } catch (e) {
    //   throw BadRequestException("something went  wrong");
    // }
  }
}

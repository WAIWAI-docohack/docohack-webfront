import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';

class API {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://restapi-waiwai.p0x0q.com/api/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
  String bearer;

  API([this.bearer]);

  String getBearer() => bearer;

  Future<dynamic> getRequest(String url,
      [Map<String, dynamic> queryParameters]) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    };

    print('[$url] submit: ${json.encode(headers)}');
    if (queryParameters != null)
      print('[$url] queryParameters: ${json.encode(queryParameters)}');

    try {
      Response<dynamic> response = await dio.get(url,
          options: Options(headers: headers), queryParameters: queryParameters);
      print('[$url] response: $response');
      return response.data;
    } catch (e) {
      print('[$url] error: ${e.response}');
      return e.response.data;
    }
  }

  Future<dynamic> postRequest(String url,
      [Map<String, dynamic> queryParameters]) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    };

    print('[$url] submit: ${json.encode(headers)}');
    if (queryParameters != null)
      print('[$url] queryParameters: ${json.encode(queryParameters)}');

    try {
      Response<dynamic> response = await dio.post(url,
          options: Options(headers: headers),
          data: FormData.fromMap(queryParameters));
      print('[$url] response: $response');
      return response.data;
    } catch (e) {
      print('[$url] error: ${e.response}');
      return e.response.data;
    }
  }

  Future<dynamic> postImageRequest(String url,
      [FormData queryParameters]) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    };

    print('[$url] submit: ${json.encode(headers)}');

    try {
      Response<dynamic> response = await dio.post(url,
          options: Options(headers: headers),
          data: queryParameters);
      print('[$url] response: $response');
      return response.data;
    } catch (e) {
      print('[$url] error: ${e.response}');
      return e.response.data;
    }
  }

  Future<dynamic> putRequest(String url,
      [Map<String, dynamic> queryParameters]) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    };

    print('[$url] submit: ${json.encode(headers)}');
    if (queryParameters != null)
      print('[$url] queryParameters: ${json.encode(queryParameters)}');

    try {
      Response<dynamic> response = await dio.put(url,
          options: Options(headers: headers),
          data: queryParameters);
      print('[$url] response: $response');
      return response.data;
    } catch (e) {
      print('[$url] error: ${e.response}');
      return e.response.data;
    }
  }

  Future<dynamic> deleteRequest(String url,
      [Map<String, dynamic> queryParameters]) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    };

    print('[$url] submit: ${json.encode(headers)}');
    if (queryParameters != null)
      print('[$url] queryParameters: ${json.encode(queryParameters)}');

    try {
      Response<dynamic> response = await dio.delete(url,
          options: Options(headers: headers),
          data: queryParameters);
      print('[$url] response: $response');
      return response.data;
    } catch (e) {
      print('[$url] error: ${e.response}');
      return e.response.data;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
        BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        /*headers: {}*/));
  }

  static Future getData(
      {@required String? url,
       Map<String, dynamic>? queries,
        String lang= "en",
        String? token
      }) {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang":lang,
      "Authorization": token
    };
    return dio.get(url!, queryParameters: queries);
  }


  static Future postData(
      {@required String? url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queries,
      String lang = "en",
      String? token}) async {
    dio.options.headers = {"Content-Type": "application/json", "lang": lang, "Authorization": token};
    return await dio.post(url!, data: data, queryParameters: queries);
  }

  static Future putData(
      {@required String? url,
        Map<String, dynamic>? data,
        Map<String, dynamic>? queries,
        String lang = "en",
        String? token}) async {
    dio.options.headers = {"Content-Type": "application/json", "lang": lang, "Authorization": token};
    return await dio.put(url!, data: data, queryParameters: queries);
  }
}

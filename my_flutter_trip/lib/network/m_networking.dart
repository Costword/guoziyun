import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseURL = 'https://www.guoziyun.com/';

m_postUrlWithParams(String url, Map<String, dynamic> param) async {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;

  String time = '';
  String userid = (prefs.getString('user_id') ?? '111') ;
  String key = '!G@Z\$YXXW';
  String str = '';
  var tody = new DateTime.now();

  String month = '${tody.month}';
  String day = '${tody.day}';
  String hour = '${tody.hour}';
  String minute = '${tody.minute}';

  if (month.length == 1) {
    month = '0' + month;
  }
  if (day.length == 1) {
    day = '0' + day;
  }
  if (hour.length == 1) {
    hour = '0' + hour;
  }
  if (minute.length == 1) {
    minute = '0' + minute;
  }
  time = '${tody.year}' + month + day + hour + minute;
  str = '$time' + '$key' + '$url' + '$userid';
  str = generateMd5(str);
  final sign = sha1String(str);
  String fullurl = '$baseURL' + '$url?' + 'user_id=$userid&' + 'sign=$sign&';
  List<String> keys = [];
  param.keys.map((key) => {
        keys.add(key),
      });

  keys.forEach((key) {
    String appendStr = '';
    if (key == keys.last) {
      appendStr = key + '=' + param[key];
    } else {
      appendStr = key + '=' + param[key] + '&';
    }
    fullurl = fullurl + appendStr;
  });

  var dio = Dio(BaseOptions(
    baseUrl: fullurl,
    connectTimeout: 5000,
    //链接超时时间
    receiveTimeout: 100000,
    //接收超时时间
    // 5s
//    headers: {
//      HttpHeaders.userAgentHeader: "dio",
//      "api": "1.0.0",
//    },
    contentType: Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
  ));
  Response response;

  response = await dio.post(
    "/post",
    data: param,
    // Send data with "application/x-www-form-urlencoded" format
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  try {
    if (response.statusCode == 200) {
      return response;
    }
  } catch (error) {
    print(error.toString());
    return error;
  }
//  var jsonData = json.encode(response.toString());
}

m_startLogin() async {
  String time = '';
  String userid = '111';
  String mybaseUrl = 'api/user/loginPass';
  String key = '!G@Z\$YXXW';
  String password = '123456';
  String str = '';
  var tody = new DateTime.now();

  String month = '${tody.month}';
  String day = '${tody.day}';
  String hour = '${tody.hour}';
  String minute = '${tody.minute}';

  if (month.length == 1) {
    month = '0' + month;
  }
  if (day.length == 1) {
    day = '0' + day;
  }
  if (hour.length == 1) {
    hour = '0' + hour;
  }
  if (minute.length == 1) {
    minute = '0' + minute;
  }
  time = '${tody.year}' + month + day + hour + minute;
  str = '$time' + '$key' + '$mybaseUrl' + '$userid';
  str = generateMd5(str);
  password = generateMd5(password);
  final sign = sha1String(str);
  String fullurl = '$baseURL' +
      '$mybaseUrl?' +
      'user_id=$userid&' +
      'sign=$sign&' +
      'phone=15516562513&' +
      'password=$password&system=ios';

  var dio = Dio(BaseOptions(
    baseUrl: fullurl,
    connectTimeout: 5000,
    receiveTimeout: 100000,
    // 5s
//    headers: {
//      HttpHeaders.userAgentHeader: "dio",
//      "api": "1.0.0",
//    },
    contentType: Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
  ));

  Response response;

//  response = await dio.get("/get");
//  Map<String, dynamic> json = response.data;
//  print(json);

//  Response<Map> responseMap = await dio.get(
//    "/get",
//    // Transform response data to Json Map
//    options: Options(responseType: ResponseType.json),
//  );
//  print(responseMap.data);
  response = await dio.post(
    "/post",
    data: {"phone": '15516562513', "password": password, "system": 'ios'},
    // Send data with "application/x-www-form-urlencoded" format
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );
  print(response.data);

//  response = await dio.request(
//    "/",
//    options: RequestOptions(baseUrl: "https://baidu.com"),
//  );
//  print(response.data);
}

String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);

  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

String sha1String(String tex) {
  var bytes = utf8.encode(tex); // data being hashed
  var digest = sha1.convert(bytes);
  return hex.encode(digest.bytes);
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mob/model/common/result_model.dart';
import 'package:dio/dio.dart';

String httpPrefix = dotenv.env['HTTP_URL']!;

Future<Map<String, String>> get header async => {
  'Content-Type': 'application/json',
  // HttpHeaders.authorizationHeader: 'Bearer ${await getToken()}'
};

Future<ResultModel> postRequest(url, data) async {
  String fullUrl = httpPrefix + url;

  final response = await http.post(
    Uri.parse(fullUrl),
    headers: await header,
    body: data != null ? json.encode(data) : null
  );

  Map<String, dynamic> jsonData = json.decode(response.body);
  ResultModel resultModel = ResultModel.fromJson(jsonData);

  return resultModel;
}

// DIO를 활용한 GET 요청
Future<ResultModel> getRequest(url, Map<String, dynamic> data) async {
  final dio = Dio();

  String fullUrl = httpPrefix + url;

  var response = await dio.get(
      fullUrl,
      queryParameters: data
  );

    final resultModel = ResultModel.fromJson(response.data);
    print('ResultModel: ${resultModel.message}');

  return resultModel;
}
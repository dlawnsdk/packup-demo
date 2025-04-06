import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mob/model/common/result_model.dart';

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

Future<ResultModel> getRequest(url, Map<String, dynamic> data) async {
  final Uri fullUrl = Uri.parse(url).replace(
    queryParameters: data
  );

  final response = await http.get(
    fullUrl,
    headers: await header,
  );

  Map<String, dynamic> jsonData = json.decode(response.body);
  ResultModel resultModel = ResultModel.fromJson(jsonData);

  return resultModel;
}
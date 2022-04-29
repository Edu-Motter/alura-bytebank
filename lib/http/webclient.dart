
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/models.dart';

void findAll() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(Uri.parse('http://192.168.0.104:8080/transactions'));
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('\n--- Request ---');
    debugPrint('Url: ${data.url}');
    debugPrint('Headers: ${data.headers.toString()}');
    debugPrint('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('\n--- Response ---');
    debugPrint('Status code: ${data.statusCode}');
    debugPrint('Headers: ${data.headers.toString()}');
    debugPrint('Body: ${data.body}');
    return data;
  }
}

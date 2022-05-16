import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'interceptors/logging_interceptors.dart';

Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 10));

Uri baseUrl = Uri.parse('http://192.168.100.25:8080/transactions');

Map<String, String> headers = {
  'password' : '1000',
  'Content-type' : 'application/json'
};

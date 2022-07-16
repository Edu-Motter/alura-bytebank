import 'dart:convert';

import 'package:http/http.dart';

import '../webclient.dart';

class I18nWebClient {
  final String viewKey;

  I18nWebClient(this.viewKey);

  static const baseUrl = 'https://gist.githubusercontent.com/Edu-Motter/0df685348e12f78d118cb79e1d12b8c0/raw/bee27e29f54191e81e55f4393ba4675799552bfa/';

  Future<Map<String, dynamic>> findAll() async {
    final Response response =
    await client.get(Uri.parse('$baseUrl$viewKey.json'));
    final Map<String, dynamic> jsonDecoded = jsonDecode(response.body);
    return jsonDecoded;
  }
}

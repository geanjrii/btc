import 'dart:convert';

import 'package:http/http.dart' as http;

typedef Json = Map<String, dynamic>;

class BtcPriceApi {
  final http.Client _http;

  BtcPriceApi({required http.Client httpClient}) : _http = httpClient;

  Future<String> getPrice() async {
    const url = 'https://blockchain.info/ticker';
    final uri = Uri.parse(url);
    final http.Response response = await _http.get(uri);
    if (response.statusCode != 200) throw BtcPriceRequestFailure();

    final Json json = jsonDecode(response.body);
    if (!json.containsKey('BRL')) throw BtcPriceNotFoundFailure();

    final result = json['BRL']['buy'].toString();
    if (result.isEmpty) throw BtcPriceNotFoundFailure();
    return result;
  }
}

class BtcPriceRequestFailure implements Exception {}

class BtcPriceNotFoundFailure implements Exception {}

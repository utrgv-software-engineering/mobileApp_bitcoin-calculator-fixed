import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/config/globals.dart';

class BitcoinAPI {
  static Future<double> fetchPrice(http.Client client) async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to fetch price');
    }
  }
}

Future<double> getPrice(http.Client client) async {
  double price = await BitcoinAPI.fetchPrice(client);
  return price;
}

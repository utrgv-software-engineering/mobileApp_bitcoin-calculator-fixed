import 'package:http/http.dart' as http;
import 'dart:convert';

import 'config/globals.dart';

class CalculationTools {
  static Future<String> fetchConversion(http.Client client) async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate"];
    } else {
      throw Exception('Failed to load conversion rate.');
    }
  }

  static String USDtoBTC(String money) {
    double dMoney = double.parse(money);
    if (dMoney <= 0) {
      throw ArgumentError();
    }
    double conv = dMoney * 0.000036;
    String result = conv.toString() + 'BTC';
    return result;
  }

  static Future<String> BCTtoUSD(String coin) async {
    double dCoin = double.parse(coin);
    if (dCoin <= 0) {
      throw ArgumentError();
    }
    String rate = await fetchConversion(http.Client());
    double conv = dCoin * double.parse(rate);
    String result = conv.toStringAsFixed(2) + 'USD';
    return result;
  }
}

// 1 dollar = 0.000036BTC
// 1 bitcoin = 27,626.80

// double num1 = double.parse((12.3412).toStringAsFixed(2));
// 12.34
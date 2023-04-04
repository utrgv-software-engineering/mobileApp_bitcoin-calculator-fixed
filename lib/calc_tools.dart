import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config/globals.dart';

class CalculationTools {
  static Future<double> fetchConversion(http.Client client) async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to load conversion rate.');
    }
  }

  static String USDtoBTC(String pesos, price) {
    double dollars = double.parse(pesos);
    double rate = double.parse(price);

    if (dollars <= 0) {
      throw ArgumentError();
    }

    double conversion = dollars / rate;

    String result = conversion.toStringAsFixed(6) + 'BTC';
    return result;
  }

  static String BTCtoUSD(String pesos, price) {
    double coin = double.parse(pesos);
    double rate = double.parse(price);

    if (coin <= 0) {
      throw ArgumentError();
    }

    double conversion = coin * rate;

    String result = conversion.toStringAsFixed(2) + 'USD';
    return result;
  }
}

// 1 dollar = 0.000036BTC
// 1 bitcoin = 27,626.80

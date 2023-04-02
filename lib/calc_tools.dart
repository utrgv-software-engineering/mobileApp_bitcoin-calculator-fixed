import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_call.dart';
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

  static String BCTtoUSD(String coin, price) {
    String temp = coin;
    double dCoin = double.parse(temp);
    double test = dCoin * price;

    test = double.parse((test).toStringAsFixed(2));

    String usd = test.toString();

    return usd;

    //String rate = fetchConversion(http.Client());
  }

  // static const String bitcoinApiUrl =
  //     'https://api.coindesk.com/v1/bpi/currentprice/usd.json';

  // static Future<String> BCTtoUSD(String coin) async {
  //   double dCoin = double.parse(coin);
  //   if (dCoin <= 0) {
  //     throw ArgumentError('Coin value must be greater than 0.');
  //   }

  //   final response = await http.get(Uri.parse(bitcoinApiUrl));
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     final rate = double.parse(json['bpi']['USD']['rate'].replaceAll(',', ''));
  //     final conv = dCoin * rate;
  //     final result = conv.toStringAsFixed(2) + ' USD';
  //     return result;
  //   } else {
  //     throw Exception('Failed to load conversion rate: ${response.statusCode}');
  //   }
  // }
}



// 1 dollar = 0.000036BTC
// 1 bitcoin = 27,626.80

// double num1 = double.parse((12.3412).toStringAsFixed(2));
// 12.34
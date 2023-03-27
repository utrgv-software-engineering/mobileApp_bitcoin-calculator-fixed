class CalculationTools {
  static String USDtoBTC(String money) {
    double conv = double.parse(money) * 0.000036;
    String result = conv.toString() + 'BTC';
    return result;
  }

  static String BCTtoUSD(String coin) {
    double conv = double.parse(coin) * 27626.80;
    String result = conv.toStringAsFixed(2) + 'USD';
    return result;
  }
}

// 1 dollar = 0.000036BTC
// 1 bitcoin = 27,626.80

// double num1 = double.parse((12.3412).toStringAsFixed(2));
// 12.34
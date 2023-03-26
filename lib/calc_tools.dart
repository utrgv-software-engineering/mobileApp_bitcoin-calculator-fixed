class CalculationTools {
  static String USDtoBTC(double money) {
    double conv = money * 0.000036;
    String result = conv.toString();
    return result;
  }

  static String BCTtoUSD(double coin) {
    double conv = coin * 27626.80;
    String result = conv.toStringAsFixed(2);
    return result;
  }
}

// 1 dollar = 0.000036BTC
// 1 bitcoin = 27,626.80

// double num1 = double.parse((12.3412).toStringAsFixed(2));
// 12.34
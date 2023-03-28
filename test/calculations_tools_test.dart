import 'package:bitcoin_calculator/calc_tools.dart';
import 'package:test/test.dart';

void main() {
  group('Dollars to bitcoin conversion', () {
    test('Calculates 1 dollars to bitcoin', () {
      var bitcoin = CalculationTools.USDtoBTC('1');
      expect(bitcoin, '0.000036BTC');
    });
    test('Calculates 20 dollars to bitcoin', () {
      var bitcoin = CalculationTools.USDtoBTC('20');
      expect(bitcoin, '0.00072BTC');
    });
    test('throws ArgumentError on zero', () {
      expect(() => CalculationTools.USDtoBTC('0'), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CalculationTools.USDtoBTC('0'), throwsArgumentError);
    });
  });
  group('Bitcoin to dollars conversion', () {
    test('Calculates 1 bitcoin to dollars', () {
      var dollars = CalculationTools.BCTtoUSD('1');
      expect(dollars, '27626.80USD');
    });
    test('Calculates 20 bitcoin to dollars', () {
      var dollars = CalculationTools.BCTtoUSD('20');
      expect(dollars, '552536.00USD');
    });
    test('throws ArgumentError on zero', () {
      expect(() => CalculationTools.BCTtoUSD('0'), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CalculationTools.BCTtoUSD('0'), throwsArgumentError);
    });
  });
}

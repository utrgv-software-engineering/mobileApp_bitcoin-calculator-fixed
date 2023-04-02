import 'package:flutter_test/flutter_test.dart';
import 'package:bitcoin_calculator/calc_tools.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main() {
  group('fetchConversion', () {
    test('returns a String if the http call completes successfully', () async {
      final client = MockClient();
      final fakeConversionAPIData =
          '{"time":{"updated":"Apr 1, 2023 22:52:00 UTC","updatedISO":"2023-04-01T22:52:00+00:00","updateduk":"Apr 1, 2023 at 23:52 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,536.0012","description":"United States Dollar","rate_float":28536.0012}}}';

      var url =
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

      when(client.get(url))
          .thenAnswer((_) async => http.Response(fakeConversionAPIData, 200));

      String conversion = await CalculationTools.fetchConversion(client);
      expect(conversion, isA<String>());
      expect(conversion, "28,536.0012");
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      var url =
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(CalculationTools.fetchConversion(client), throwsException);
    }, skip: true);
  });
}

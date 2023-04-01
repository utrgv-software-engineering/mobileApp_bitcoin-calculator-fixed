import 'package:flutter_test/flutter_test.dart';
import 'package:bitcoin_calculator/calc_tools.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main() {
  test('our fetchConversion call returns our rate converion correctly',
      () async {
    final client = MockClient();
    final fakeConversionRateAPIData =
        '{"time":{"updated":"Apr 1, 2023 22:46:00 UTC","updatedISO":"2023-04-01T22:46:00+00:00","updateduk":"Apr 1, 2023 at 23:46 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,540.3880","description":"United States Dollar","rate_float":28540.388}}}';
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

    when(client.get(url))
        .thenAnswer((_) async => http.Response(fakeConversionRateAPIData, 200));

    String conversion = await CalculationTools.fetchConversion(http.Client());

    expect(conversion, isA<String>());
    expect(conversion, "28,540.3880");
  });

  test('our fetchConversion call returns our rate converion incorrectly',
      () async {});
}

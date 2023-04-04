import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:bitcoin_calculator/config/globals.dart' as globals;

class MockClient extends Mock implements http.Client {}

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  final MockClient client = MockClient();

  final fakeConversionAPIData =
      '{"time":{"updated":"Apr 2, 2023 00:20:00 UTC","updatedISO":"2023-04-02T00:20:00+00:00","updateduk":"Apr 2, 2023 at 01:20 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,498.9107","description":"United States Dollar","rate_float":28498.9107}}}';
  var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
  when(client.get(url))
      .thenAnswer((_) async => http.Response(fakeConversionAPIData, 200));

  globals.httpClient = client;

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}

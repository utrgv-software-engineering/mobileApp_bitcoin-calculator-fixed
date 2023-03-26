// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // group('Counter App', () {
  //   // First, define the Finders and use them to locate widgets from the
  //   // test suite. Note: the Strings provided to the `byValueKey` method must
  //   // be the same as the Strings we used for the Keys in step 1.
  //   final counterTextFinder = find.byValueKey('counter');
  //   final buttonFinder = find.byValueKey('increment');

  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  // });

  group('Testing if user can see UI elements', () {
    test('User should see options conversion options USD to BTC and BTC to USD',
        () async {
      // Use driver to find buttons that will be available to users
      final firstOption = find.byValueKey('USD');
      final secondOption = find.byValueKey('BTC');
      expect(await driver.getText(firstOption), "USD to BTC");
      expect(await driver.getText(secondOption), "BTC to USD");
    });
  });
}

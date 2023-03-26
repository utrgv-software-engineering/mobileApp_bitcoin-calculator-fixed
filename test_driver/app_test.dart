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

    test('User should see the new page when selecting on USD to BTC', () async {
      final firstOption = find.byValueKey('USD');
      final prompt = find.byValueKey('Prompt');
      final back = find.byValueKey('back-button');

      await driver.tap(firstOption);

      expect(await driver.getText(prompt),
          'How many Dollars would you like to convert?');

      await driver.tap(back);
    });

    test('User should see the new page when selecting on BTC to USD', () async {
      final firstOption = find.byValueKey('BTC');
      final prompt = find.byValueKey('Prompt');
      final back = find.byValueKey('back-button');

      await driver.tap(firstOption);

      expect(await driver.getText(prompt),
          'How many Bitcoin would you like to convert?');

      await driver.tap(back);
    });

    test('User should be able to enter value to convert from USD to BTC',
        () async {
      final secondOption = find.byValueKey('USD');
      final prompt = find.byValueKey('Prompt');
      final back = find.byValueKey('back-button');
      final inputField = find.byValueKey('input-field');
      final calculate = find.byValueKey('calc');
      final result = find.byValueKey('converted');
      await driver.tap(secondOption);

      expect(await driver.getText(prompt),
          'How many Dollars would you like to convert?');
      driver.tap(inputField);
      driver.enterText('1');
      driver.tap(calculate);

      expect(await driver.getText(result), 'Conversion Result: 0.000036BTC');
    }, skip: true);
  });
}

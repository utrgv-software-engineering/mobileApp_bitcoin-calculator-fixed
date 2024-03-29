// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
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

  final conversionTextFinder = find.byValueKey('converted');

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
  });

  group(
      'User entering values to convert should return correct value, now with Mockito',
      () {
    test(
      'User should be able to enter value to convert from USD to BTC',
      () async {
        final secondOption = find.byValueKey('USD');
        final prompt = find.byValueKey('Prompt');
        final back = find.byValueKey('back-button');
        final inputField = find.byValueKey('input-field');
        final calculate = find.byValueKey('calc');

        await driver.tap(secondOption);

        expect(await driver.getText(prompt),
            'How many Dollars would you like to convert?');
        await driver.tap(inputField);
        await driver.enterText('1');
        await driver.tap(calculate);

        expect(await driver.getText(conversionTextFinder),
            'Conversion Result: 0.000035BTC');
        await driver.tap(back);
      },
    );
    test('User should be able to enter value to convert from BTC to USD',
        () async {
      final secondOption = find.byValueKey('BTC');
      final prompt = find.byValueKey('Prompt');
      final back = find.byValueKey('back-button');
      final inputField = find.byValueKey('input-field');
      final calculate = find.byValueKey('calc');

      await driver.tap(secondOption);

      expect(await driver.getText(prompt),
          'How many Bitcoin would you like to convert?');
      await driver.tap(inputField);
      await driver.enterText('1');
      await driver.tap(calculate);

      expect(await driver.getText(conversionTextFinder),
          'Conversion Result: 28498.91USD');
      await driver.tap(back);
    });
  });
}

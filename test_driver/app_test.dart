import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('EComApp', () {
    final incrementButtonFinder = find.byValueKey("increment1");
    final incrementTextFinder = find.byValueKey("increment1Value");

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test("on initilized should be on 0", () async {
      expect(await driver.getText(incrementTextFinder), "I am count 0");
    });

    test("on increment should be on 1", () async {
      await driver.tap(incrementButtonFinder);

      expect(await driver.getText(incrementTextFinder), "I am count 1");
    });

    test("on increment should be on 1 - again", () async {
      await driver.tap(incrementButtonFinder);

      expect(await driver.getText(incrementTextFinder), "I am count 2");
    });
  });
}

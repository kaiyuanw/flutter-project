import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:async';
import 'package:multi_counter/keys.dart';

void main() {
  group('Count Test', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: 'http://localhost:8183');
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('tap', () async {
      for(int i = 0; i < 5; i++) {
        await driver.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 500));
      }
      // String result1 = await driver1.getText(find.byValueKey(textKey));
      // expect(result1, equals('Button tapped 5 times.'));
      // await new Future<Null>.delayed(new Duration(milliseconds: 10000));
    });
  });
}

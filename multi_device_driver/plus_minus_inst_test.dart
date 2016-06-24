import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:mdtest/src/driver/driver_util.dart';
import 'dart:async';
import 'keys.dart';

void main() {
  group('Count Test', () {
    FlutterDriver driver1;
    FlutterDriver driver2;

    setUpAll(() async {
      driver1 = await DriverUtil.connectByName(deviceNickname: 'Alice');
      driver2 = await DriverUtil.connectByName(deviceNickname: 'Bob');
      // driver1 = await FlutterDriver.connect(dartVmServiceUrl: 'http://localhost:8106');
      // driver2 = await FlutterDriver.connect(dartVmServiceUrl: 'http://localhost:8108');
    });

    tearDownAll(() async {
      if (driver1 != null) {
        driver1.close();
      }
      if (driver2 != null) {
        driver2.close();
      }
    });

    test('tap', () async {
      for(int i = 0; i < 5; i++) {
        await driver1.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 2000));
      }
      String result1 = await driver1.getText(find.byValueKey(textKey));
      expect(result1, equals('Button tapped 5 times.'));
      String result2 = await driver2.getText(find.byValueKey(textKey));
      expect(result2, equals('Button tapped 5 times.'));
      // await new Future<Null>.delayed(new Duration(milliseconds: 10000));
      for(int i = 0; i < 3; i++) {
        await driver2.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 2000));
      }
      result1 = await driver1.getText(find.byValueKey(textKey));
      expect(result1, equals('Button tapped 2 times.'));
      result2 = await driver2.getText(find.byValueKey(textKey));
      expect(result2, equals('Button tapped 2 times.'));
    });
  });
}

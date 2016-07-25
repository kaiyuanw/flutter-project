import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:mdtest/driver_util.dart';

import 'keys.dart';
import 'utils.dart' as utils;

void main() {
  group('Count Test 1', () {
    FlutterDriver driver1;
    FlutterDriver driver2;

    setUpAll(() async {
      await utils.resetCounter();
      driver1 = await DriverUtil.connectByName('Alice');
      driver2 = await DriverUtil.connectByName('Bob');
      // driver1 = await FlutterDriver.connect(dartVmServiceUrl: 'http://localhost:43447');
      // driver2 = await FlutterDriver.connect(dartVmServiceUrl: 'http://localhost:41024');
    });

    tearDownAll(() async {
      if (driver1 != null) {
        driver1.close();
      }
      if (driver2 != null) {
        driver2.close();
      }
    });

    test('tap increase 2 times', () async {
      await new Future<Null>.delayed(new Duration(milliseconds: 3000));
      for(int i = 0; i < 2; i++) {
        await driver1.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 2000));
        print('Driver 1: ${await driver1.getText(find.byValueKey(textKey))}');
        print('Driver 2: ${await driver2.getText(find.byValueKey(textKey))}');
      }
      String result1 = await driver1.getText(find.byValueKey(textKey));
      expect(result1, equals('Button tapped 2 times.'));
      String result2 = await driver2.getText(find.byValueKey(textKey));
      expect(result2, equals('Button tapped 2 times.'));
    });

    test('tap decrease 2 times', () async {
      await new Future<Null>.delayed(new Duration(milliseconds: 1000));
      for(int i = 0; i < 2; i++) {
        await driver2.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 2000));
        print('Driver 2: ${await driver2.getText(find.byValueKey(textKey))}');
        print('Driver 1: ${await driver1.getText(find.byValueKey(textKey))}');
      }
      String result1 = await driver1.getText(find.byValueKey(textKey));
      expect(result1, equals('Button tapped 0 times.'));
      String result2 = await driver2.getText(find.byValueKey(textKey));
      expect(result2, equals('Button tapped 0 times.'));
      // fail('No reason failure.');
    });
  });

  group('Count Test 2', () {
    FlutterDriver driver1;
    FlutterDriver driver2;

    setUpAll(() async {
      await utils.resetCounter();
      driver1 = await DriverUtil.connectByName('Alice');
      driver2 = await DriverUtil.connectByName('Bob');
    });

    tearDownAll(() async {
      if (driver1 != null) {
        driver1.close();
      }
      if (driver2 != null) {
        driver2.close();
      }
    });

    test('tap decrease 1 times', () async {
      await new Future<Null>.delayed(new Duration(milliseconds: 3000));
      for(int i = 0; i < 1; i++) {
        await driver2.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 2000));
        print('Driver 2: ${await driver2.getText(find.byValueKey(textKey))}');
        print('Driver 1: ${await driver1.getText(find.byValueKey(textKey))}');
      }
      String result1 = await driver1.getText(find.byValueKey(textKey));
      expect(result1, equals('Button tapped -1 times.'));
      String result2 = await driver2.getText(find.byValueKey(textKey));
      expect(result2, equals('Button tapped -1 times.'));
    });

    test('tap increase 1 times', () async {
      await new Future<Null>.delayed(new Duration(milliseconds: 1000));
      for(int i = 0; i < 1; i++) {
        await driver1.tap(find.byValueKey(buttonKey));
        await new Future<Null>.delayed(new Duration(milliseconds: 2000));
        print('Driver 1: ${await driver1.getText(find.byValueKey(textKey))}');
        print('Driver 2: ${await driver2.getText(find.byValueKey(textKey))}');
      }
      String result1 = await driver1.getText(find.byValueKey(textKey));
      expect(result1, equals('Button tapped 0 times.'));
      String result2 = await driver2.getText(find.byValueKey(textKey));
      expect(result2, equals('Button tapped 0 times.'));
    });
  });
}

import 'dart:async';
import 'package:test/test.dart';
import 'utils.dart' as utils;

void main() {
  group('Group X', () {
    // setUp(() {});
    setUpAll(() async {
      await utils.resetCounter();
    });
    // tearDown(() {});
    // tearDownAll(() {});
    test('Test X 1', (){
      fail('Some reason');
    }, skip: false);
    test('Test X 2', (){
    }, skip: false);
    test('Test X 3', (){
      fail('Some reason');
    }, skip: false);
  }, skip: false);

  group('Group Y', () {
    // setUp(() {});
    // setUpAll(() {});
    // tearDown(() {});
    // tearDownAll(() {});
    test('Test Y 1', (){
      fail('Some reason');
    }, skip: false);
    test('Test Y 2', (){
    }, skip: false);
  }, skip: false);
}

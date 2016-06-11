import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('this is a widget test', (WidgetTester tester) async {
    Key sliderKey = new UniqueKey();
    double value = 0.0;

    await tester.pumpWidget(
      new StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return new Material(
            child: new Center(
              child: new Slider(
                key: sliderKey,
                value: value,
                onChanged: (double newValue) {
                  setState(() {
                    value = newValue;
                  });
                }
              )
            )
          );
        }
      )
    );
    expect(value, equals(0.0));

    await tester.tap(find.byKey(sliderKey));

    expect(value, equals(0.5));
  });
}

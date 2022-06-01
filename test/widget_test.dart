// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child components in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:dominhduong/utils/extensions.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test extension function", () {
    test("Duration", () {
      int a = 3434;
      String test = a.secondToHourMinute;
      print(test);
    });

  });
}

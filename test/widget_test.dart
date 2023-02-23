

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_duan/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());
  });
}


import 'package:flutter/material.dart';
import "package:flutter_duan/page/home_page.dart" show HomePage, products;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('home page test', () {
    Finder checkBtn() => find.text('check');
    Finder nextBtn() => find.text('Next');
    Finder priceInput() => find.byKey(const Key('priceInput'));
    testWidgets(
      ''
      'Click Next to interate over the product list ',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));
        expect(find.text(products[0].name), findsOneWidget);

        for (var i = 1; i < 5; i++) {
          await tester.tap(checkBtn());
          await tester.pump();
          await tester.tap(nextBtn());
          await tester.pump();
          expect(find.text(products[i].name), findsOneWidget);
        }

        await tester.tap(checkBtn());
        await tester.pump();
        expect(find.text(products[4].name), findsOneWidget);
      },
    );

    testWidgets('check result & show next product',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));
      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(priceInput(), '0');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextBtn());
      await tester.pump();

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(priceInput(), '2');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text('fail'), findsOneWidget);

      await tester.enterText(priceInput(), '3');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}

import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';
import '../mocks/save_contatact_flow.mocks.dart';

void main() {

  Future<void> _buildDashboardScreen(WidgetTester tester) async {
    return tester.pumpWidget(
      AppDependencies(
        transactionWebClient: MockTransactionWebClient(),
        contactDao: MockContactDao(),
        appChild: const MaterialApp(
          home: Dashboard(),
        ),
      ),
    );
  }

  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    await _buildDashboardScreen(tester);
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'Should display the transfer feature when the Dashboard is opened',
      (WidgetTester tester) async {
    await _buildDashboardScreen(tester);
    final transferFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(
        widget,
        icon: Icons.monetization_on,
        title: 'Transfer',
      );
    });

    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed feature when the Dashboard is opened',
      (WidgetTester tester) async {
    await _buildDashboardScreen(tester);
    final transactionFeatureItem =
        find.byWidgetPredicate((widget) => featureItemMatcher(
              widget,
              icon: Icons.description,
              title: 'Transaction Feed',
            ));

    expect(transactionFeatureItem, findsOneWidget);
  });
}

import 'package:bytebank/components/dialogs.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transactions_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/save_contatact_flow.mocks.dart';

void main() {
  testWidgets('transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    final contactEduardo = Contact(1, 'Eduardo', 1000);
    final contactLuiza = Contact(2, 'Luiza', 2000);

    when(mockContactDao.findAll())
        .thenAnswer((_) => Future.value([contactEduardo, contactLuiza]));
    when(mockContactDao.save(any)).thenAnswer((_) => Future.value(0));
    when(mockTransactionWebClient.save(any, any))
        .thenAnswer((_) => Future.value(Transaction('1', 200, contactEduardo)));

    await tester.pumpWidget(
      BytebankApp(
        transactionWebClient: mockTransactionWebClient,
        contactDao: mockContactDao,
      ),
    );

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget,
            icon: Icons.monetization_on, title: 'Transfer'));
    expect(transferFeatureItem, findsOneWidget);
    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);
    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Eduardo' &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Eduardo');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate(
      (widget) => textFieldMatcher(widget, 'Value'),
    );
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword =
        find.byKey(TransactionAuthDialog.textFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(TextButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
  });
}

import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/save_contatact_flow.mocks.dart';

@GenerateMocks([ContactDao, TransactionWebClient])
void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();

    when(mockContactDao.findAll()).thenAnswer((_) =>
        Future.value([Contact(1, 'Eduardo', 1), Contact(2, 'Luiza', 2)]));
    when(mockContactDao.save(any)).thenAnswer((_) => Future.value(0));

    await tester.pumpWidget(BytebankApp(
      transactionWebClient: MockTransactionWebClient(),
      contactDao: mockContactDao,
    ));

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

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
    await tester.pumpAndSettle();

    final nameTextField = find
        .byWidgetPredicate((widget) => textFieldMatcher(widget, 'Full name'));
    await tester.enterText(nameTextField, 'Eduardo');
    expect(nameTextField, findsOneWidget);

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, 'Account number'));
    await tester.enterText(accountNumberTextField, '1000');
    expect(accountNumberTextField, findsOneWidget);

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(1, 'Eduardo', 1000)));

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
  });
}


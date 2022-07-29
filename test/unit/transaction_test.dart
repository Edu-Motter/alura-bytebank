import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the value when create a transaction', () {
    final transaction = Transaction('0', 200, Contact(1, 'Eduardo', 0));
    expect(transaction.value, 200);
  });

  test('Should show an error when the value is less than zero', () {
    expect(() => Transaction('0', -10, Contact(1, 'Eduardo', 0)),
        throwsAssertionError);
  });
}

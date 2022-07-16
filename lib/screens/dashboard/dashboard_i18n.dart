import 'package:bytebank/components/localization/i18n_eager.dart';
import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:flutter/widgets.dart';

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  //ignore: non_constant_identifier_names
  String get change_name => _messages.get('change_name');

  String get transfer => _messages.get('transfer');

  //ignore: non_constant_identifier_names
  String get transaction_feed => _messages.get('transaction_feed');
}

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  //ignore: non_constant_identifier_names
  String get change_name =>
      localize({'pt-br': 'Trocar nome', 'en': 'Change name'});

  String get transfer => localize({'pt-br': 'Transferir', 'en': 'Transfer'});

  //ignore: non_constant_identifier_names
  String get transaction_feed =>
      localize({'pt-br': 'Transferencias', 'en': 'Transaction Feed'});
}

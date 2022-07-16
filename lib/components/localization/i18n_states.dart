import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class InitState extends I18NMessagesState {
  const InitState();
}

@immutable
class LoadingState extends I18NMessagesState {
  const LoadingState();
}

@immutable
class LoadedState extends I18NMessagesState {
  final I18NMessages messages;
  const LoadedState(this.messages);
}


@immutable
class FatalErrorState extends I18NMessagesState {
  final String message;
  const FatalErrorState(this.message);
}

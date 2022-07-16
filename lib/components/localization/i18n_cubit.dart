import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:bytebank/components/localization/i18n_states.dart';
import 'package:bytebank/http/webclients/i18n_webclient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final String _viewKey;
  final LocalStorage storage = LocalStorage('some_key.json');

  I18NMessagesCubit(this._viewKey) : super(const InitState());

  void reload(I18nWebClient client) async {
    emit(const LoadingState());
    await storage.ready;
    final items = storage.getItem(_viewKey);
    if(items != null){
      emit(LoadedState(I18NMessages(items)));
      return;
    }
    client.findAll().then(saveAndRefresh);
  }

  void saveAndRefresh(Map<String, dynamic> messages){
    storage.setItem(_viewKey, messages);
    debugPrint('Saving on local storage..');
    emit(LoadedState(I18NMessages(messages)));
  }
}
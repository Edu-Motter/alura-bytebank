import 'package:bytebank/components/error_view.dart';
import 'package:bytebank/components/localization/i18n_container.dart';
import 'package:bytebank/components/localization/i18n_cubit.dart';
import 'package:bytebank/components/localization/i18n_states.dart';
import 'package:bytebank/components/progress_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator _creator;

  const I18NLoadingView(this._creator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is LoadingState || state is InitState) {
          return const ProgressView(message: 'Loading..');
        }
        if (state is LoadedState) {
          final messages = state.messages;
          return _creator.call(messages);
        }
        return const ErrorView(
          message: 'Erro ao carregar mensagens',
        );
      },
    );
  }
}
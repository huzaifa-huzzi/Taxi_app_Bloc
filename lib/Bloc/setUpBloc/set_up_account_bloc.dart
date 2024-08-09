import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_up_account_event.dart';
part 'set_up_account_state.dart';

class SetUpAccountBloc extends Bloc<SetUpAccountEvent, SetUpAccountState> {
  SetUpAccountBloc() : super(SetUpAccountInitial()) {
    on<SetUpAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

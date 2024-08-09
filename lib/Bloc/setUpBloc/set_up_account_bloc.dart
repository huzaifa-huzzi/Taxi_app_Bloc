import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_event.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_state.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
final DatabaseReference _databaseReference;

AccountSetupBloc(this._databaseReference) : super(AccountSetupState()) {
on<FirstNameChanged>((event, emit) {
emit(state.copyWith(firstName: event.firstName));
});

on<LastNameChanged>((event, emit) {
emit(state.copyWith(lastName: event.lastName));
});

on<EmailChanged>((event, emit) {
emit(state.copyWith(email: event.email));
});

on<SubmitAccountSetup>((event, emit) async {
emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));

try {
await _databaseReference.child('users').push().set({
'first_name': state.firstName,
'last_name': state.lastName,
'email': state.email,
});

emit(state.copyWith(isSubmitting: false, isSuccess: true));
} catch (e) {
emit(state.copyWith(isSubmitting: false, isFailure: true));
}
});
}
}
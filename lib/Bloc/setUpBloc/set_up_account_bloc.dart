import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_event.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_state.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  AccountSetupBloc() : super(const AccountSetupState());

  @override
  Stream<AccountSetupState> mapEventToState(AccountSetupEvent event) async* {
    if (event is FirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is LastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is EmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is SubmitAccountSetup) {
      await _dbRef.push().set({
        'firstName': state.firstName,
        'lastName': state.lastName,
        'email': state.email,
      });
    }
  }
}

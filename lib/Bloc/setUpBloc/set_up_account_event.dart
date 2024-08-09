import 'package:equatable/equatable.dart';

abstract class AccountSetupEvent extends Equatable {
  const AccountSetupEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends AccountSetupEvent {
  final String firstName;

  const FirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends AccountSetupEvent {
  final String lastName;

  const LastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class EmailChanged extends AccountSetupEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SubmitAccountSetup extends AccountSetupEvent {}

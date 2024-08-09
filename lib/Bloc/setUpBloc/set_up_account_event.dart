

abstract class AccountSetupEvent {}

class FirstNameChanged extends AccountSetupEvent {
  final String firstName;
  FirstNameChanged(this.firstName);
}

class LastNameChanged extends AccountSetupEvent {
  final String lastName;
  LastNameChanged(this.lastName);
}

class EmailChanged extends AccountSetupEvent {
  final String email;
  EmailChanged(this.email);
}

class SubmitAccountSetup extends AccountSetupEvent {}

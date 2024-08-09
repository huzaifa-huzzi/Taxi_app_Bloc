import 'package:equatable/equatable.dart';

class AccountSetupState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;

  const AccountSetupState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  AccountSetupState copyWith({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return AccountSetupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email];
}

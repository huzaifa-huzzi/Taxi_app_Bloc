import 'package:flutter/rendering.dart';

class AccountSetupState {
  final String firstName;
  final String lastName;
  final String email;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool internetException ;

  AccountSetupState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.internetException = false,
  });

  AccountSetupState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? internetException
  }) {
    return AccountSetupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      internetException: internetException ?? this.internetException
    );
  }

  @override
  List<Object?> get props => [firstName,lastName,email,isSubmitting,isSuccess,isFailure,internetException];
}

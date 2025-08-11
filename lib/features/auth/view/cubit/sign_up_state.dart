import 'dart:io';

class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String errorMessage;
  SignUpError(this.errorMessage);
}

class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool isObscure;
  SignUpPasswordVisibilityChanged(this.isObscure);
}

class SignUpStrongPasswordChanged extends SignUpState {
  final bool isStrong;
  SignUpStrongPasswordChanged(this.isStrong);
}

class SignUpBrandLogoSelected extends SignUpState {
  final File logoFile;
  SignUpBrandLogoSelected(this.logoFile);
}

class SignUpBrandLogoRemoved extends SignUpState {}

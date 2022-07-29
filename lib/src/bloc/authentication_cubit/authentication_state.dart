part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {}

class AuthenticationLoggedOut extends AuthenticationState {}

class AuthenticationLoggingOut extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError(this.error);
}

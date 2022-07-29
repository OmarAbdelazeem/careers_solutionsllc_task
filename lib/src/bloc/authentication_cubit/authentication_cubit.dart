import 'package:careers_solutionsllc_task/src/data/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationCubit(this._authenticationRepository)
      : super(AuthenticationInitial());

  void autoLoginStarted() async {
    User? loggedInUser;
    try {
      loggedInUser = _authenticationRepository.getCurrentUser();

      if (loggedInUser != null) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationLoggedOut());
      }
    } catch (e) {
      print(e.toString());
      emit(AuthenticationError(e.toString()));
    }
  }

  void loginAnonymously() async {
    User? loggedInUser;
    try {
      emit(AuthenticationLoading());
      loggedInUser = await _authenticationRepository.loginAnonymously();
      await Future.delayed(const Duration(milliseconds: 10));
      if (loggedInUser != null) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFailed());
      }
    } catch (e) {
      print(e.toString());
      emit(AuthenticationError(e.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthenticationLoggingOut());
      await _authenticationRepository.logout();
      emit(AuthenticationLoggedOut());
    } catch (e) {
      print(e.toString());
      emit(AuthenticationError(e.toString()));
    }
  }
}

import 'dart:async';

import 'package:analytics_repository/analytics_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'login_with_email_link_event.dart';
part 'login_with_email_link_state.dart';

class LoginWithEmailLinkBloc
    extends Bloc<LoginWithEmailLinkEvent, LoginWithEmailLinkState> {
  LoginWithEmailLinkBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const LoginWithEmailLinkState()) {
    on<LoginWithEmailLinkSubmitted>(_onLoginWithEmailLinkSubmitted);

    _userRepository.user
        .handleError(addError)
        .listen((user) => add(LoginWithEmailLinkSubmitted(user)));
  }

  final UserRepository _userRepository;

  Future<void> _onLoginWithEmailLinkSubmitted(
    LoginWithEmailLinkSubmitted event,
    Emitter<LoginWithEmailLinkState> emit,
  ) async {
    // Si el usuario no tiene email, no intentar login
    final email = event.user.email;
    if (email == null || event.user.isAnonymous) {
      return; // Ignorar evento si es usuario anónimo
    }

    emit(state.copyWith(status: LoginWithEmailLinkStatus.loading));
    try {
      await _userRepository.logInWithEmailLink(
        email: email,
        emailLink: email,
      );
      emit(state.copyWith(status: LoginWithEmailLinkStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoginWithEmailLinkStatus.failure));
      addError(error, stackTrace);
    }
  }
}

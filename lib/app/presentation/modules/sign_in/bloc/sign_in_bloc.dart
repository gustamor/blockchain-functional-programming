import 'package:bloc/bloc.dart';
import 'package:functional_programming/app/domain/models/users/user.dart';
import 'package:functional_programming/app/domain/repositories/auth_repository.dart';
import 'package:functional_programming/app/domain/typedefs.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_bloc.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_events.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(
    super.initialState, {
    required AuthRepository authRepository,
    required SessionBloc sessionBloc,
  })  : _authRepository = authRepository,
        _sessionBloc = sessionBloc {
    on<SignInEMailChangedEvent>(
      (event, emit) => emit(
        state.copyWith(
          email: event.email,
        ),
      ),
    );
    on<SignInPasswordChangedEvent>(
      (event, emit) => emit(
        state.copyWith(
          password: event.password,
        ),
      ),
    );
    on<SignInTermsChangedEvent>(
      (event, emit) => emit(
        state.copyWith(
          termsAccepted: event.termsAccepted,
        ),
      ),
    );
  }

  final AuthRepository _authRepository;
  final SessionBloc _sessionBloc;

  HttpFuture<User> signIn() async {
    final result = await _authRepository.signIn(
      state.email,
      state.password,
    );

    result.whenOrNull(
      right: (user) => _sessionBloc.add(
        SessionEvent.setUser(user),
      ),
    );
    return result;
  }
}

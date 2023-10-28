import 'package:bloc/bloc.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(super.initialState) {
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
}

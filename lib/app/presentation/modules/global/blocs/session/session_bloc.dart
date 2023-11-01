import 'package:bloc/bloc.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_events.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc(super.initialState) {
    on<SessionSetUserEvent>(
      (event, emit) => emit(
        state.copyWith(
          user: event.user,
        ),
      ),
    );
    on<SessionSignOutEvent>(
      (event, emit) => emit(
        state.copyWith(
          user: null,
        ),
      ),
    );
  }
}

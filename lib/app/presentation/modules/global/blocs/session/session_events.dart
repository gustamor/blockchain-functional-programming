import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/users/user.dart';

part 'session_events.freezed.dart';

@freezed
class SessionEvent with _$SessionEvent {
  factory SessionEvent.setUser(User user) = SessionSetUserEvent;
  factory SessionEvent.signOut() = SessionSignOutEvent;
}

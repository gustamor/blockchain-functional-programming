import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.freezed.dart';

@freezed
class SignInEvent with _$SignInEvent {
  factory SignInEvent.emailChanged(String email) = SignInEMailChangedEvent;
  factory SignInEvent.passwordChanged(String password) =
      SignInPasswordChangedEvent;
  factory SignInEvent.termsAccepted(bool termsAccepted) =
      SignInTermsChangedEvent;
}

import "package:freezed_annotation/freezed_annotation.dart";
import "package:functional_programming/app/domain/failures/http_request_failure.dart";

import "../../../../domain/models/crypto/crypto.dart";
import "../../../../domain/models/ws_status/ws_status.dart";

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.loading() = _Loading;

  factory HomeState.failed(HttpRequestFailure failure) = _Failed;

  factory HomeState.loaded(
      {required List<Crypto> cryptos,
       @Default(WsStatus.connecting()) WsStatus wsStatus}) = _Loaded;
}




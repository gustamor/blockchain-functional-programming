import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:functional_programming/app/domain/models/ws_status/ws_status.dart';

import '../../../../domain/models/crypto/crypto.dart';

part 'home_events.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent{
  factory HomeEvent.initialize() = InitializeEvent;
  factory HomeEvent.updateWsState(WsStatus wsStatus) = UpdateWsStateEvent;
  factory HomeEvent.updateCryptoPrices(Map<String,double> prices) = UpdateCryptoPricesEvent;
  factory HomeEvent.delete(Crypto crypto) = DeleteEvent;
}
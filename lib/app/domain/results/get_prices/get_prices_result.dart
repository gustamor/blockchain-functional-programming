import 'package:functional_programming/app/domain/models/crypto/crypto.dart';

import '../../failures/http_request_failure.dart';

abstract class GetPricesResult {}

class GetPricesSuccess extends GetPricesResult {
  GetPricesSuccess(this.cryptos);
  final List<Crypto> cryptos;
}

class GetPricesFailure extends GetPricesResult {
  GetPricesFailure(this.failure);
  final HttpRequestFailure failure;
}
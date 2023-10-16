import 'package:functional_programming/app/domain/failures/http_request_failure.dart';
import 'package:functional_programming/app/domain/models/crypto/crypto.dart';

import '../either/either.dart';
import '../results/get_prices/get_prices_result.dart';


typedef GetPriceFuture =  Future<Either<HttpRequestFailure, List<Crypto>>>;

abstract class ExchangeRepository {
  GetPriceFuture getPrices(List<String> ids);
}
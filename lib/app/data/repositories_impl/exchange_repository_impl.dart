import 'package:functional_programming/app/data/services/remote/exchange_api.dart';
import 'package:functional_programming/app/domain/repositories/exchange_repository.dart';
import 'package:functional_programming/app/domain/results/get_prices/get_prices_result.dart';

class ExChangeRepositoryImpl implements ExchangeRepository {
  final ExchangeAPI _api;

  ExChangeRepositoryImpl(this._api);

  @override
  GetPriceFuture getPrices(List<String> ids) {
    return _api.getPrices(ids);
  }


}

import 'package:functional_programming/app/data/services/remote/exchange_api.dart';
import 'package:functional_programming/app/domain/repositories/exchange_repository.dart';
import 'package:functional_programming/app/domain/typedefs.dart';

class ExChangeRepositoryImpl implements ExchangeRepository {
  final ExchangeAPI _api;

  ExChangeRepositoryImpl(this._api);

  @override
  HttpFuture getPrices(List<String> ids) {
    return _api.getPrices(ids);
  }
}

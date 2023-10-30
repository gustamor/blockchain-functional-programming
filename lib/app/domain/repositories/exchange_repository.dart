import 'package:functional_programming/app/domain/typedefs.dart';

abstract class ExchangeRepository {
  HttpFuture getPrices(List<String> ids);
}

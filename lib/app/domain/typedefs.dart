import 'package:functional_programming/app/domain/either/either.dart';
import 'package:functional_programming/app/domain/failures/http_request_failure.dart';

typedef HttpFuture<T> = Future<Either<HttpRequestFailure, T>>;

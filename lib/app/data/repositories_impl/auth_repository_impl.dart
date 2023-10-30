import 'package:functional_programming/app/domain/either/either.dart';
import 'package:functional_programming/app/domain/failures/http_request_failure.dart';
import 'package:functional_programming/app/domain/models/users/user.dart';

import 'package:functional_programming/app/domain/typedefs.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  HttpFuture<User> signIn(String email, String password) async {
    Future.delayed(
      const Duration(seconds: 2),
    );
    if (email == 'test@test.com' && password == "123456") {
      return Either.right(
        User(
          id: 123,
          name: 'Gustavo',
          avatar: null,
        ),
      );
    } else {
      return Either.left(
        HttpRequestFailure.unauthorized(),
      );
    }
  }
}

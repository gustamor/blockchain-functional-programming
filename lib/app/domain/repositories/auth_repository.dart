import 'package:functional_programming/app/domain/typedefs.dart';

import '../models/users/user.dart';

abstract class AuthRepository {
  HttpFuture<User> signIn(String email, String password);
}

import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignInUsecase implements Usecase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignInUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email, password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}

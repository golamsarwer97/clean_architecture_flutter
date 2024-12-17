import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignUpUsecase implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name, email, password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

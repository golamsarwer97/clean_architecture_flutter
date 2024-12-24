import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class CurrentUserUsecase implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUserUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

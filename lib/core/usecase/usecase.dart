import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

abstract interface class Usecase<SucessType, Params> {
  Future<Either<Failure, SucessType>> call(Params params);
}

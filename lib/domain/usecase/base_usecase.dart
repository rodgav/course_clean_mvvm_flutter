import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/network/failure.dart';

abstract class BaseUseCase<In,Out> {
  Future<Either<Failure,Out>> execute(In input);
}


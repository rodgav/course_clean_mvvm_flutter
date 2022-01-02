import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/network/failure.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/repository/repository.dart';
import 'package:juliaca_store0/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, ForgotPassword> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPassword>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}

import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/network/failure.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/repository/repository.dart';
import 'package:juliaca_store0/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void,Home>{
  Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> execute(void input)async {
    return await _repository.home();
  }

}
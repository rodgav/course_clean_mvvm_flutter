import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/network/failure.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/repository/repository.dart';
import 'package:juliaca_store0/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<int, StoreDetails> {
  Repository _repository;

  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(int input) async {
    return await _repository.storeDetails(input);
  }
}

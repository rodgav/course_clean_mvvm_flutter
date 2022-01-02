import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/network/failure.dart';
import 'package:juliaca_store0/data/request/request.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/repository/repository.dart';
import 'package:juliaca_store0/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.countryMobile,
        input.name,
        input.email,
        input.password,
        input.mobileNumber,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String countryMobile;
  String name;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput(this.countryMobile, this.name, this.email, this.password,
      this.mobileNumber, this.profilePicture);
}

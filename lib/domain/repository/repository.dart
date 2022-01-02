import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/network/failure.dart';
import 'package:juliaca_store0/data/request/request.dart';
import 'package:juliaca_store0/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, ForgotPassword>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);

  Future<Either<Failure, Home>> home();
  Future<Either<Failure, StoreDetails>> storeDetails(int id);
}

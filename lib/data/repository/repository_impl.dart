import 'package:dartz/dartz.dart';
import 'package:juliaca_store0/data/data_source/local_data_source.dart';
import 'package:juliaca_store0/data/data_source/remote_data_source.dart';
import 'package:juliaca_store0/data/network/error_handler.dart';
import 'package:juliaca_store0/data/network/failure.dart';
import 'package:juliaca_store0/data/network/network_info.dart';
import 'package:juliaca_store0/data/request/request.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalResponse.succes) {
          return Right(response);
        } else {
          return Left(Failure(response.status, response.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPassword>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalResponse.succes) {
          return Right(response);
        } else {
          return Left(Failure(response.status, response.message));
        }
      } catch (error) {
        //print('error $error');
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalResponse.succes) {
          return Right(response);
        } else {
          return Left(Failure(response.status, response.message));
        }
      } catch (error) {
        //print('error $error');
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Home>> home() async {
    try {
      final response = await _localDataSource.getHome();
      return Right(response);
    } catch (cacheErro) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.home();
          if (response.status == ApiInternalResponse.succes) {
            _localDataSource.saveHomeToCache(response);
            return Right(response);
          } else {
            return Left(Failure(response.status, response.message));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
  @override
  Future<Either<Failure, StoreDetails>> storeDetails(int id) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.storeDetails(id);
        if (response.status == ApiInternalResponse.succes) {
          return Right(response);
        } else {
          return Left(Failure(response.status, response.message));
        }
      } catch (error) {
        //print('error $error');
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}

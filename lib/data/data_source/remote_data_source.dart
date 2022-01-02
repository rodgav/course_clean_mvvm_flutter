import 'package:juliaca_store0/data/network/app_api.dart';
import 'package:juliaca_store0/data/request/request.dart';
import 'package:juliaca_store0/domain/model/model.dart';

abstract class RemoteDataSource {
  Future<Authentication> login(LoginRequest loginRequest);

  Future<ForgotPassword> forgotPassword(String email);

  Future<Authentication> register(RegisterRequest registerRequest);

  Future<Home> home();

  Future<StoreDetails> storeDetails(int id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<Authentication> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
  }

  @override
  Future<ForgotPassword> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<Authentication> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.countryMobile,
        registerRequest.name,
        registerRequest.email,
        registerRequest.password,
        registerRequest.mobileNumber,
        registerRequest.profilePicture);
  }

  @override
  Future<Home> home() async {
    return await _appServiceClient.home();
  }

  @override
  Future<StoreDetails> storeDetails(int id) async {
    return await _appServiceClient.storeDetails(id);
  }
}

import 'package:dio/dio.dart';
import 'package:juliaca_store0/data/responses/responses.dart';
import 'package:juliaca_store0/domain/model/model.dart';

class AppServiceClient {
  Dio _dio;

  AppServiceClient(this._dio);

  Future<Authentication> login(
      String email, String password, String imei, String deviceType) async {
    final response = await _dio.post('/customers/login', data: {
      'email': email,
      'password': password,
      'imei': imei,
      'deviceType': deviceType
    });
    return authenticationFromJson(response.data);
  }

  Future<ForgotPassword> forgotPassword(String email) async {
    final response = await _dio.post('/customers/forgotpassword', data: {
      'email': email,
    });
    return forgotPasswordfromJson(response.data);
  }

  Future<Authentication> register(
      String countryMobile,
      String name,
      String email,
      String password,
      String mobileNumber,
      String profilePicture) async {
    final response = await _dio.post('/customers/register', data: {
      'country_mobile': countryMobile,
      'name': name,
      'email': email,
      'password': password,
      'mobile_number': mobileNumber,
      'profile_picture': ''
    });
    return authenticationFromJson(response.data);
  }

  Future<Home> home() async {
    final response = await _dio.get('/home');
    return homeFromJson(response.data);
  }

  Future<StoreDetails> storeDetails(int id) async {
    final response = await _dio.get('/storeDetails/$id');
    return storeDetailsFromJson(response.data);
  }
}

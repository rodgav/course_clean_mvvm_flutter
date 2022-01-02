import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';
//todo: flutter pub run build_runner build

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String countryMobile,
      String name,
      String email,
      String password,
      String mobileNumber,
      String profilePicture) = _RegisterObject;
}

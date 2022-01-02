class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class RegisterRequest {
  String countryMobile;
  String name;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterRequest(this.countryMobile, this.name, this.email, this.password,
      this.mobileNumber, this.profilePicture);
}

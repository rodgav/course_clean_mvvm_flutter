import 'dart:async';
import 'dart:io';

import 'package:juliaca_store0/app/functions.dart';
import 'package:juliaca_store0/domain/usecase/register_usecase.dart';
import 'package:juliaca_store0/presentation/base/base_viewmodel.dart';
import 'package:juliaca_store0/presentation/common/freezed_data_classes.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final _usernameStreCtrl = StreamController<String>.broadcast();
  final _mobileNumberStreCtrl = StreamController<String>.broadcast();
  final _emailStreCtrl = StreamController<String>.broadcast();
  final _passwordStreCtrl = StreamController<String>.broadcast();
  final _profilePictureStreCtrl = StreamController<File>.broadcast();
  final _isAllInputsValidStreCtrl = StreamController<void>.broadcast();
  final isUserLoggedInSuccesStreCtrl = StreamController<bool>();

  final RegisterUseCase _registerUseCase;

  var _registerObject = RegisterObject('', '', '', '', '', '');

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreCtrl.close();
    _mobileNumberStreCtrl.close();
    _emailStreCtrl.close();
    _passwordStreCtrl.close();
    _profilePictureStreCtrl.close();
    _isAllInputsValidStreCtrl.close();isUserLoggedInSuccesStreCtrl.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreCtrl.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreCtrl.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreCtrl.sink;

  @override
  Sink get inputPassword => _passwordStreCtrl.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreCtrl.sink;

  @override
  Sink get inputUsername => _usernameStreCtrl.sink;

  @override
  Stream<bool> get outputEmail => _emailStreCtrl.stream.map(isEmailValid);

  @override
  Stream<String?> get outputErrorEmail =>
      outputEmail.map((isEmailValid) => isEmailValid ? null : 'Invalid email');

  @override
  Stream<bool> get outputUsername =>
      _usernameStreCtrl.stream.map((username) => _usernameValid(username));

  @override
  Stream<String?> get outputErrorUsername => outputUsername
      .map((isUsernameValid) => isUsernameValid ? null : 'Invalid username');

  @override
  Stream<bool> get outputMobileNumber => _mobileNumberStreCtrl.stream
      .map((mobileNumber) => _mobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputMobileNumber.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : 'Invalid mobile number');

  @override
  Stream<bool> get outputPassword =>
      _passwordStreCtrl.stream.map((password) => _passwordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputPassword
      .map((isPasswordValid) => isPasswordValid ? null : 'Invalid Password');

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreCtrl.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputsValidStreCtrl.stream.map((_) => _validateAllInputs());

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadinState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            _registerObject.countryMobile,
            _registerObject.name,
            _registerObject.email,
            _registerObject.password,
            _registerObject.mobileNumber,
            _registerObject.profilePicture)))
        .fold((f) {
      //failure
      inputState.add(ErrorState(StateRendererType.popupErrorState, f.message));
    }, (r) {
      //succes
      inputState.add(ContentState());
      isUserLoggedInSuccesStreCtrl.add(true);
    });
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    if (_usernameValid(username)) {
      _registerObject = _registerObject.copyWith(name: username);
    } else {
      _registerObject = _registerObject.copyWith(name: '');
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      _registerObject = _registerObject.copyWith(email: email);
    } else {
      _registerObject = _registerObject.copyWith(email: '');
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      _registerObject = _registerObject.copyWith(countryMobile: countryCode);
    } else {
      _registerObject = _registerObject.copyWith(countryMobile: '');
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_mobileNumberValid(mobileNumber)) {
      _registerObject = _registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      _registerObject = _registerObject.copyWith(mobileNumber: '');
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_passwordValid(password)) {
      _registerObject = _registerObject.copyWith(password: password);
    } else {
      _registerObject = _registerObject.copyWith(password: '');
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      _registerObject =
          _registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      _registerObject = _registerObject.copyWith(profilePicture: '');
    }
    _validate();
  }

  bool _usernameValid(String username) {
    return username.length >= 8;
  }

  bool _mobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 9;
  }

  bool _passwordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return _registerObject.profilePicture.isNotEmpty &&
        _registerObject.email.isNotEmpty &&
        _registerObject.password.isNotEmpty &&
        _registerObject.mobileNumber.isNotEmpty &&
        _registerObject.countryMobile.isNotEmpty &&
        _registerObject.name.isNotEmpty;
  }

  void _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  register();

  setUsername(String username);

  setCountryCode(String countryCode);

  setMobileNumber(String mobileNumber);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);

  Sink get inputUsername;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputIsAllInputValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputUsername;

  Stream<String?> get outputErrorUsername;

  Stream<bool> get outputMobileNumber;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputEmail;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputPassword;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputIsAllInputValid;
}

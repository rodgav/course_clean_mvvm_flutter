import 'dart:async';

import 'package:juliaca_store0/domain/usecase/login_usecase.dart';
import 'package:juliaca_store0/presentation/base/base_viewmodel.dart';
import 'package:juliaca_store0/presentation/common/freezed_data_classes.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final _userNameStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _isAllInputsValidStreamController = StreamController<void>.broadcast();
  final isUserLoggedInSuccesStreamController = StreamController<String>();

  var _loginObject = LoginObject('', '');
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccesStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    _loginObject = _loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadinState));
    (await _loginUseCase.execute(
        LoginUseCaseInput(_loginObject.userName, _loginObject.password)))
        .fold(
            (f)
        {
          //failure
          inputState.add(
              ErrorState(StateRendererType.popupErrorState, f.message));
        },
            (r)  {
        //succes
        inputState.add(ContentState());
        isUserLoggedInSuccesStreamController.add('abcdefgh');
    });
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream
          .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameStreamController.stream
          .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(_loginObject.password) &&
        _isUserNameValid(_loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}

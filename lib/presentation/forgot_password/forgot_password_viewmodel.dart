import 'dart:async';

import 'package:juliaca_store0/domain/usecase/forgot_password_usecase.dart';
import 'package:juliaca_store0/presentation/base/base_viewmodel.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final _usernameStreamController = StreamController<String>.broadcast();
  final _inputValidStreamController = StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  String email = '';

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadinState));
    (await _forgotPasswordUseCase.execute(email)).fold((f) {
      //failure
      inputState.add(ErrorState(StateRendererType.popupErrorState, f.message));
    }, (r) {
      //succes
      inputState.add(SuccessState(
          StateRendererType.popupSuccessState, r.message, r.support));
    });
  }

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputValid => _inputValidStreamController.sink;

  @override
  Stream<bool> get outputUsername => _usernameStreamController.stream
      .map((username) => _isValidUsername(username));

  @override
  Stream<bool> get outputValid =>
      _inputValidStreamController.stream.map((_) => _inputValid());

  @override
  setUsername(String username) {
    inputUsername.add(username);
    email = username;
    _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _inputValidStreamController.close();
  }

  _inputValid() {
    return _isValidUsername(email);
  }

  _validate() {
    inputValid.add(null);
  }

  bool _isValidUsername(String username) {
    return username.isNotEmpty;
  }
}

abstract class ForgotPasswordViewModelInputs {
  setUsername(String username);

  forgotPassword();

  Sink get inputUsername;

  Sink get inputValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputUsername;

  Stream<bool> get outputValid;
}

import 'dart:async';

import 'package:flutter_advanced_course/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced_course/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer_impl.dart';

import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  LoginUseCase? _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputAllInputs => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(
        username: username); // data class operation same as kotlin
    _validate();
  }

  @override
  login() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    (await _loginUseCase!.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold(
      (failure) => {
        // left - failure
        inputState.add(
          ErrorState(
            StateRendererType.POPUP_ERROR_STATE,
            failure.message,
          ),
        )
      },
      (data) => {
        // right - success
        inputState.add(
          ContentState(),
        )
      },
    );
  }

  _validate() {
    inputAllInputs.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.username);
  }
}

abstract class LoginViewModelInputs {
  // 3 functions for actions
  setUsername(String username);
  setPassword(String password);
  login();

  // two sinks for streams
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAllInputs;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}

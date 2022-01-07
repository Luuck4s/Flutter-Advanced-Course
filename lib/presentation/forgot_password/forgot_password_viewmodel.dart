import 'dart:async';

import 'package:flutter_advanced_course/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_advanced_course/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  StreamController _usernameStreamController =
      StreamController<String>.broadcast();

  StreamController isForgotPasswordSendSuccessfullyController =
      StreamController<bool>();

  var email = "";
  ForgotPasswordUseCase? _fogotPasswordUseCase;

  ForgotPasswordViewModel(this._fogotPasswordUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    isForgotPasswordSendSuccessfullyController.close();
    super.dispose();
  }

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  send() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE),
    );

    (await _fogotPasswordUseCase!.execute(ForgotPasswordUseCaseInput(email)))
        .fold(
            (failure) => {
                  inputState.add(
                    ErrorState(
                        StateRendererType.POPUP_ERROR_STATE, failure.message),
                  ),
                },
            (data) => {
                  inputState.add(ContentState()),
                  isForgotPasswordSendSuccessfullyController.add(true)
                });
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    email = username;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  @override
  Sink get inputUsername => _usernameStreamController.sink;
}

abstract class ForgotPasswordViewModelInputs {
  setUsername(String username);
  send();

  Sink get inputUsername;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
}

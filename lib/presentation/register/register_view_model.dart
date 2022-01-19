import 'dart:async';
import 'dart:io';

import 'package:flutter_advanced_course/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced_course/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_course/presentation/common/freezed_data_classes.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<File>.broadcast();

  StreamController isUserRegisteredInSuccessfullyController =
      StreamController<bool>();

  RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerViewObject.mobileNumber,
      registerViewObject.countryMobileCode,
      registerViewObject.userName,
      registerViewObject.email,
      registerViewObject.password,
      registerViewObject.profilePicture,
    )))
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
        ),

        isUserRegisteredInSuccessfullyController.add(true),
      },
    );
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<File> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid Username");

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(
        countryMobileCode: countryCode,
      );
    } else {
      registerViewObject = registerViewObject.copyWith(
        countryMobileCode: "",
      );
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerViewObject =
          registerViewObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerViewObject = registerViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(
        profilePicture: profilePicture.path,
      );
    } else {
      registerViewObject = registerViewObject.copyWith(
        profilePicture: "",
      );
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerViewObject = registerViewObject.copyWith(userName: userName);
    } else {
      registerViewObject = registerViewObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream
          .map((event) => _validateAllInputs());

  _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+")
        .hasMatch(email);
  }

  _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.userName.isNotEmpty &&
        registerViewObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  register();

  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;

  Stream<bool> get outputIsAllInputsValid;
}

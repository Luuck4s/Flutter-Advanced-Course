import 'package:flutter_advanced_course/data/network/app_api.dart';
import 'package:flutter_advanced_course/data/request/request.dart';
import 'package:flutter_advanced_course/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<AuthenticationResponse> register(RegisterRequest request);
  Future<HomeResponse> getHome();
  Future<StoreDetailsResponse> getStoreDetails();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    return await _appServiceClient.forgotPassword(
      forgotPasswordRequest.email,
    );
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.countryMobileCode,
      registerRequest.mobileNumber,
      registerRequest.userName,
      registerRequest.email,
      registerRequest.password,
      // registerRequest.profilePicture,
      "",
    );
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    return await _appServiceClient.getStoreDetails();
  }
}

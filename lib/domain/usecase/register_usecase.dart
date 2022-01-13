import 'package:flutter_advanced_course/app/functions.dart';
import 'package:flutter_advanced_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_course/data/request/request.dart';
import 'package:flutter_advanced_course/domain/model/model.dart';
import 'package:flutter_advanced_course/domain/repository/repository.dart';
import 'package:flutter_advanced_course/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.countryMobileCode,
      input.userName,
      input.email,
      input.password,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
    this.countryMobileCode,
    this.userName,
    this.email,
    this.password,
    this.profilePicture,
  );
}

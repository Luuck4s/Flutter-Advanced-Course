import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_course/data/network/failure.dart';
import 'package:flutter_advanced_course/data/request/request.dart';
import 'package:flutter_advanced_course/data/responses/responses.dart';
import 'package:flutter_advanced_course/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotPassword>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
}

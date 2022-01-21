import 'package:flutter_advanced_course/app/functions.dart';
import 'package:flutter_advanced_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_course/data/request/request.dart';
import 'package:flutter_advanced_course/domain/model/model.dart';
import 'package:flutter_advanced_course/domain/repository/repository.dart';
import 'package:flutter_advanced_course/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}

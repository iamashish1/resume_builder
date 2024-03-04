import 'package:dartz/dartz.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/usecase/usecase.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:resume_builder/features/authentication/domain/entity/user.dart';
import 'package:resume_builder/features/authentication/domain/repository/authentication_repository.dart';

class SignIn implements Usecase<UserModel, LoginRequestModel> {
  AuthenticationRepository repository;
  SignIn(this.repository);
  @override
  Future<Either<AppException, UserModel>> call(LoginRequestModel params) async {
    return await repository.loginUser(params);
  }
}

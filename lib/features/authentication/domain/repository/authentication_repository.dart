import 'package:dartz/dartz.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:resume_builder/features/authentication/domain/entity/user.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, UserModel>> loginUser(LoginRequestModel params);
}

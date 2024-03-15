import 'package:dartz/dartz.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/app_exceptions/check_exceptions.dart';
import 'package:resume_builder/features/authentication/data/data_source/remote_data_source.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:resume_builder/features/authentication/domain/entity/user.dart';
import 'package:resume_builder/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppException, UserModel>> loginUser(
      LoginRequestModel params) async {
    try {
      final res = await remoteDataSource.loginUser(params);
      return Right(res);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }
}

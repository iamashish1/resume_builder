import 'package:dartz/dartz.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/usecase/usecase.dart';
import 'package:resume_builder/features/authentication/domain/entity/user.dart';
import 'package:resume_builder/features/authentication/domain/repository/authentication_repository.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class GetResumeTemplate implements Usecase<UserModel,NoParams>{
  AuthenticationRepository repository;
  GetResumeTemplate(this.repository);
  @override
  Future<Either<AppException, ResumeModel>> call(NoParams params) async{
   return  repository.loginUser(params);
  }

}



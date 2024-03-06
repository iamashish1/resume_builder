import 'package:dartz/dartz.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/usecase/usecase.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class GetResumeTemplate implements Usecase<ResumeModel,NoParams>{

  @override
  Future<Either<AppException, ResumeModel>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}



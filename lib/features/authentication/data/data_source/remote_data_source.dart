import 'package:resume_builder/features/authentication/data/model/fireabse_user.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:resume_builder/features/authentication/domain/entity/user.dart';

abstract class RemoteDataSource {
  Future<FirebaseUser> loginUser(LoginRequestModel params);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<FirebaseUser> loginUser(LoginRequestModel params) {
    return Future.value(FirebaseUser(id: 1));
  }
}

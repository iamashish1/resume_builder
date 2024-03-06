import 'package:resume_builder/features/authentication/data/model/fireabse_user.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';

abstract class RemoteDataSource {
  Future<FirebaseUser> loginUser(LoginRequestModel params);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<FirebaseUser> loginUser(LoginRequestModel params) {
    return Future.value(FirebaseUser(id: 1));
  }
}

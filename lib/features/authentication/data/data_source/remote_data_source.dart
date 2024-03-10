import 'package:firebase_auth/firebase_auth.dart';
import 'package:resume_builder/features/authentication/data/model/fireabse_user.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RemoteDataSource {
  Future<FirebaseUser> loginUser(LoginRequestModel params);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<FirebaseUser> loginUser(LoginRequestModel params) async {
    UserCredential? user;
    if (params.isSignUp == false) {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: params.email, password: params.password);
    } else {
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: params.email, password: params.password);
    }
    //SAVE TO SAHREDPREFS
    final pref = await SharedPreferences.getInstance();
    pref.setString("user", user.toString());
    //END SHAREDPREFS

    return Future.value(FirebaseUser(id: user.user?.displayName ?? ""));
  }
}

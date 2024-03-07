import 'package:resume_builder/features/authentication/domain/entity/user.dart';

class FirebaseUser extends UserModel{
  FirebaseUser({required String id}) : super(id: id);

  factory FirebaseUser.fromJson(Map<String, dynamic> json) {
    return FirebaseUser(
      id: json['id'],
    );
  }
}

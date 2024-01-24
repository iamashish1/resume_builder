import 'package:resume_builder/features/authentication/domain/entity/user.dart';

class FirebaseUser extends User {
  FirebaseUser({required int id}) : super(id: id);

  factory FirebaseUser.fromJson(Map<String, dynamic> json) {
    return FirebaseUser(
      id: json['id'],
    );
  }
}

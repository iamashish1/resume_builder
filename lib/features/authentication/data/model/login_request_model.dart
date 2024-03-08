class LoginRequestModel {
  String password;
  bool isSignUp;
  String email;
  LoginRequestModel({required this.email,required this.isSignUp, required this.password});
}

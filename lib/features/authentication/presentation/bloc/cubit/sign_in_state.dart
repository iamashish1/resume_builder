part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial({
    @Default(false) bool isLoading,
    String? error,
  }) = _Initial;
    const factory SignInState.fetched(
      {
    @Default(false) bool isLoading,
    String? error,
    required UserModel data,
  }
    ) = _Fetched;

}
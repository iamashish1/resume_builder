import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:resume_builder/features/authentication/domain/entity/user.dart';
import 'package:resume_builder/features/authentication/domain/usecases/sign_in_cubit.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

class SignInCubit extends Cubit<SignInState> {
  SignIn usecase;
  SignInCubit(this.usecase) : super(SignInState.initial());

  void signInUser(LoginRequestModel params) async {
    final response = await usecase(params);

    response.fold((l) => null, (r) => null);
  }
}

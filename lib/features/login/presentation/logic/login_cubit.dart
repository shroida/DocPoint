import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/login/domain/usecase/user_login_usecase.dart';
import 'package:docpoint/features/login/presentation/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserLoginUsecase _loginUsecase;
  final CurrentUserCubit currentUserCubit;
  LoginCubit(this._loginUsecase, this.currentUserCubit) : super(LoginInitial());

  // Form key for login Form
  final formKey = GlobalKey<FormState>();

  // Login controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> login() async {
    emit(LoginLoading());
    final response = await _loginUsecase.call(LoginParams(
      email: emailController.text,
      password: passwordController.text,
    ));

    response.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) {
        emit(LoginSuccess(user));
        currentUserCubit.updateUser(user); // optionally set the current user
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

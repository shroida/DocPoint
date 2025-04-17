import 'package:docpoint/core/common/data/datasources/current_user_remote_datasources.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/login/domain/usecase/user_login_usecase.dart';
import 'package:docpoint/features/login/presentation/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserLoginUsecase _loginUsecase;
  final CurrentUserCubit _currentUserCubit;
  final CurrentUserRemoteDatasources _userDatasources;

  LoginCubit(this._loginUsecase, this._currentUserCubit, this._userDatasources)
      : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // @override
  // Future<void> close() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   return super.close();
  // }

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.call(LoginParams(
        email: emailController.text,
        password: passwordController.text,
      ));

      response.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (user) async {
          final userData = await _userDatasources.getCurrentUserData();
          await _currentUserCubit.updateUser(userData.toUserEntity());
          emit(LoginSuccess(userData.toUserEntity()));
        },
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

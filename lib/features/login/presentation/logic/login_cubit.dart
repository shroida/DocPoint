import 'package:docpoint/features/login/presentation/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  // Form key for login Form
  final formKey = GlobalKey<FormState>();

  // Login controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginCubit() : super(LoginInitial());
}

import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrentUserAuthenticated) {
            return Center(child: Text('Welcome ${state.user.city}'));
          } else if (state is CurrentUserUnauthenticated) {
            return const Center(child: Text('Not logged in'));
          } else if (state is CurrentUserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Checking auth...'));
        },
      ),
    );
  }
}

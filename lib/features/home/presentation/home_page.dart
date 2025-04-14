import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<CurrentUserCubit>().currentUser;
    return Scaffold(body: SafeArea(child: Column(
      children: [
        
      ],
    )));
  }
}

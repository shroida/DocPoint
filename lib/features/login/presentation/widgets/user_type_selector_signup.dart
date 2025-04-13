import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/login/presentation/logic/login_cubit.dart';
import 'package:docpoint/features/login/presentation/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTypeSelectorLogin extends StatelessWidget {
  const UserTypeSelectorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserCubit = context.read<CurrentUserCubit>();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select User Type',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Wrap(
                spacing: 8.0,
                children: ['Patient', 'Doctor'].map((String type) {
                  final isSelected = currentUserCubit.userType == type;
                  return ChoiceChip(
                    checkmarkColor: Colors.white,
                    label: Text(type),
                    selected: isSelected,
                    selectedColor: const Color(0xff0064FA),
                    backgroundColor: const Color(0xffF0EFFF),
                    labelStyle: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xff0064FA),
                      fontFamily: 'Poppins',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xff0064FA)
                            : const Color(0xff0064FA),
                        width: 2.0,
                      ),
                    ),
                    onSelected: (bool selected) {
                      currentUserCubit.setUserType(selected ? type : 'Patient');
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

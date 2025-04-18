import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChatListScreenForDoctorUI extends StatelessWidget {
  final List<AppointmentEntity>? appointments;
  const ChatListScreenForDoctorUI({super.key, this.appointments});

  @override
  Widget build(BuildContext context) {
    final currentUserCubit = context.read<CurrentUserCubit>();
    bool isDoctor = currentUserCubit.userType == "Doctor";

    final List<AppointmentEntity> uniqueAppointments = isDoctor
        ? {for (var a in appointments!) a.patientId: a}.values.toList()
        : [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop(); // This will navigate back
          },
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text("Chats", style: AppStyle.heading1),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: uniqueAppointments.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.divider,
          thickness: 1,
          height: 20.h,
        ),
        itemBuilder: (context, index) {
          final appointment = uniqueAppointments[index];

          return ListTile(
            onTap: () {
              context.push(Routes.chatPage,
                  extra: ChatScreenArgs(
                    image: '',
                    category: appointment.category,
                    friendName: appointment.patientName,
                    friendId: appointment.patientId,
                  ));
            },
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 26.r,
              child: const Icon(Icons.person),
            ),
            title: Text(
              appointment.patientName,
              style: AppStyle.heading3,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              appointment.category,
              style: AppStyle.body2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }
}

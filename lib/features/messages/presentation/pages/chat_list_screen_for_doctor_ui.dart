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
    final List<Map<String, dynamic>> chatList = [
      {
        'name': 'John Doe',
        'lastMessage': 'Hey, how are you?',
        'imageUrl': 'https://i.pravatar.cc/150?img=3',
        'time': '10:45 AM',
        'unreadCount': 3,
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text("Chats", style: AppStyle.heading1),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: isDoctor ? uniqueAppointments.length : chatList.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.divider,
          thickness: 1,
          height: 20.h,
        ),
        itemBuilder: (context, index) {
          if (isDoctor) {
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
                backgroundImage: const NetworkImage(
                    "https://i.pravatar.cc/150"), // placeholder
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
          } else {
            final chat = chatList[index];
            return ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 26.r,
                backgroundImage: NetworkImage(chat['imageUrl']),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      chat['name'],
                      style: AppStyle.heading3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    chat['time'],
                    style: AppStyle.caption,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(
                      chat['lastMessage'],
                      style: AppStyle.body2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (chat['unreadCount'] > 0)
                    Container(
                      margin: EdgeInsets.only(left: 6.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${chat['unreadCount']}',
                        style: AppStyle.caption.copyWith(color: Colors.white),
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

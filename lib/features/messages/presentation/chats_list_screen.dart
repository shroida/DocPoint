import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChatsListScreen extends StatelessWidget {
  final List<DoctorEntity>? doctorsList;
  const ChatsListScreen({super.key, this.doctorsList});

  @override
  Widget build(BuildContext context) {
    final currentUserCubit = context.read<CurrentUserCubit>();
    bool isPatient = currentUserCubit.userType == "Patient";

    // Example dummy data (replace with real data from Supabase or state)
    final List<Map<String, dynamic>> chatList = [
      {
        'name': 'John Doe',
        'lastMessage': 'Hey, how are you?',
        'imageUrl': 'https://i.pravatar.cc/150?img=3',
        'time': '10:45 AM',
        'unreadCount': 3,
      },
      {
        'name': 'Zainab Elbakry',
        'lastMessage': 'Let’s catch up later!',
        'imageUrl': 'https://i.pravatar.cc/150?img=5',
        'time': '9:10 AM',
        'unreadCount': 0,
      },
      {
        'name': 'Ahmed',
        'lastMessage': 'Okay sure, see you then.',
        'imageUrl': 'https://i.pravatar.cc/150?img=8',
        'time': 'Yesterday',
        'unreadCount': 2,
      },
      {
        'name': 'John Doe',
        'lastMessage': 'Hey, how are you?',
        'imageUrl': 'https://i.pravatar.cc/150?img=3',
        'time': '10:45 AM',
        'unreadCount': 3,
      },
      {
        'name': 'Zainab Elbakry',
        'lastMessage': 'Let’s catch up later!',
        'imageUrl': 'https://i.pravatar.cc/150?img=5',
        'time': '9:10 AM',
        'unreadCount': 0,
      },
      {
        'name': 'Ahmed',
        'lastMessage': 'Okay sure, see you then.',
        'imageUrl': 'https://i.pravatar.cc/150?img=8',
        'time': 'Yesterday',
        'unreadCount': 2,
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
        itemCount: isPatient ? (doctorsList?.length ?? 0) : chatList.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.divider,
          thickness: 1,
          height: 20.h,
        ),
        itemBuilder: (context, index) {
          final chat = chatList[index];

          return ListTile(
            onTap: () {
              context.push(Routes.chatPage,
                  extra: ChatScreenArgs(
                      friendId: doctorsList![index].id,
                      currentUserId: currentUserCubit.currentUser!.id));
            },
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
                    isPatient ? doctorsList![index].firstName : chat['name'],
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
        },
      ),
    );
  }
}

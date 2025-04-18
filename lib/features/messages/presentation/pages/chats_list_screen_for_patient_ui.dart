import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/messages/presentation/logic/message_cubit.dart';
import 'package:docpoint/features/messages/presentation/logic/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChatsListScreenForPatientUI extends StatefulWidget {
  final List<DoctorEntity>? doctorsList;
  const ChatsListScreenForPatientUI({super.key, this.doctorsList});

  @override
  State<ChatsListScreenForPatientUI> createState() =>
      _ChatsListScreenForPatientUIState();
}

class _ChatsListScreenForPatientUIState
    extends State<ChatsListScreenForPatientUI> {
  @override
  void initState() {
    super.initState();
    context.read<MessageCubit>().getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text("Chats", style: AppStyle.heading1),
      ),
      body: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessagesLoaded) {
            final messages = state.messages;

            if (messages.isEmpty) {
              return const Center(child: Text("No chats yet."));
            }

            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: messages.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.divider,
                thickness: 1,
                height: 20.h,
              ),
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  onTap: () {
                    context.push(Routes.chatPage,
                        extra: ChatScreenArgs(
                          image: '',
                          category: '', // Add category if you have it
                          friendName: msg.senderId,
                          friendId: msg.senderId,
                        ));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 26.r,
                    child: const Icon(Icons.person),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          msg.senderId,
                          style: AppStyle.heading3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Yesterday', // Replace with formatted date from msg.createdAt
                        style: AppStyle.caption,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                          msg.messageText,
                          style: AppStyle.body2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!msg.isRead)
                        Container(
                          margin: EdgeInsets.only(left: 6.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'New',
                            style:
                                AppStyle.caption.copyWith(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else if (state is MessageError) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

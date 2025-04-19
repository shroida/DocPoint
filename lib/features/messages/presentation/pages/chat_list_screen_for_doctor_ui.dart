import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/messages/presentation/logic/message_cubit.dart';
import 'package:docpoint/features/messages/presentation/logic/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatListScreenForDoctorUI extends StatefulWidget {
  final List<AppointmentEntity>? appointments;
  const ChatListScreenForDoctorUI({super.key, this.appointments});

  @override
  State<ChatListScreenForDoctorUI> createState() =>
      _ChatListScreenForDoctorUIState();
}

class _ChatListScreenForDoctorUIState extends State<ChatListScreenForDoctorUI> {
  @override
  void initState() {
    super.initState();
    context.read<MessageCubit>().getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserCubit = context.read<CurrentUserCubit>();

    final List<AppointmentEntity> uniqueAppointments =
        {for (var a in widget.appointments!) a.patientId: a}.values.toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
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
              itemCount: uniqueAppointments.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.divider,
                thickness: 1,
                height: 20.h,
              ),
              itemBuilder: (context, index) {
                final patientId = uniqueAppointments[index].patientId;
                final patientName = uniqueAppointments[index].patientName;
                final relatedMessages = messages
                    .where((msg) =>
                        (msg.receiverId == patientId &&
                            msg.senderId == currentUserCubit.currentUser!.id) ||
                        (msg.senderId == patientId &&
                            msg.receiverId == currentUserCubit.currentUser!.id))
                    .toList();

                relatedMessages
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                final lastMessage =
                    relatedMessages.isNotEmpty ? relatedMessages.first : null;

                return ListTile(
                  onTap: () async {
                    context.push(Routes.chatPage,
                        extra: ChatScreenArgs(
                          relatedMessages: relatedMessages,
                          image: '',
                          category: uniqueAppointments[index].category,
                          friendName: uniqueAppointments[index].patientName,
                          friendId: uniqueAppointments[index].id,
                        ));
                    await context
                        .read<MessageCubit>()
                        .makeMessagesRead(currentUserCubit.currentUser!.id);
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
                          patientName,
                          style: AppStyle.heading3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        lastMessage != null
                            ? DateFormat('MMM dd\nhh:mm a')
                                .format(lastMessage.createdAt)
                            : '',
                        style: AppStyle.caption,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage?.messageText ?? "No messages yet",
                          style: AppStyle.body2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (relatedMessages.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(left: 6.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            relatedMessages.length.toString(),
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
            return Center(
                child: Text('Error loading messages: ${state.error}'));
          }

          return Container();
        },
      ),
    );
  }
}

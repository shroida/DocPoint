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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  leading: CircleAvatar(
                    radius: 30.r,
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        uniqueAppointments[index].patientName,
                        style: AppStyle.heading2
                            .copyWith(color: AppColors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                          height: 4), // Space between title and subtitle
                      Text(
                        lastMessage?.messageText ?? "No messages yet",
                        style: AppStyle.body2
                            .copyWith(color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lastMessage != null
                            ? DateFormat('MMM dd\nhh:mm a')
                                .format(lastMessage.createdAt)
                            : '',
                        style: AppStyle.caption
                            .copyWith(color: AppColors.textSecondary),
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

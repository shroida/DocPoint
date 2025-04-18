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
import 'package:intl/intl.dart';

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
              itemCount: widget.doctorsList?.length ?? 0,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.divider,
                thickness: 1,
                height: 20.h,
              ),
              itemBuilder: (context, index) {
                final doctorId = widget.doctorsList![index].id;

                final relatedMessages = messages
                    .where((msg) =>
                        msg.receiverId == doctorId || msg.senderId == doctorId)
                    .toList();
                relatedMessages
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                final lastMessage =
                    relatedMessages.isNotEmpty ? relatedMessages.first : null;

                return ListTile(
                  onTap: () {
                    context.push(Routes.chatPage,
                        extra: ChatScreenArgs(
                          relatedMessages: relatedMessages,
                          image: widget.doctorsList![index].imageUrl ?? '',
                          category: widget.doctorsList![index].category,
                          friendName:
                              '${widget.doctorsList![index].firstName} ${widget.doctorsList![index].lastName}',
                          friendId: widget.doctorsList![index].id,
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
                          widget.doctorsList![index].firstName,
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

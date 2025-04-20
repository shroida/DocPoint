import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
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
                  onTap: () async {
                    final currentUser =
                        context.read<CurrentUserCubit>().currentUser;

                    context.push(Routes.chatPage,
                        extra: ChatScreenArgs(
                          relatedMessages: relatedMessages,
                          image: widget.doctorsList![index].imageUrl ?? '',
                          category: widget.doctorsList![index].category,
                          friendName:
                              '${widget.doctorsList![index].firstName} ${widget.doctorsList![index].lastName}',
                          friendId: widget.doctorsList![index].id,
                        ));
                    await context
                        .read<MessageCubit>()
                        .makeMessagesRead(currentUser!.id);
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  leading: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: widget.doctorsList![index].imageUrl != null
                        ? NetworkImage(widget.doctorsList![index].imageUrl!)
                        : null,
                    child: widget.doctorsList![index].imageUrl == null
                        ? const Icon(Icons.person, color: AppColors.primary)
                        : null,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.doctorsList![index].firstName} ${widget.doctorsList![index].lastName}',
                        style: AppStyle.heading2
                            .copyWith(color: AppColors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                          height: 4), // Small space between title and subtitle
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

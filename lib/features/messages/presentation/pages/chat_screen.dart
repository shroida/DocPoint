// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/messages/domain/usecase/send_message_usecase.dart';
import 'package:docpoint/features/messages/presentation/logic/message_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_text_form_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    this.category,
    required this.image,
  });
  final String friendId;
  final String friendName;
  final String? category;
  final String image;
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        context.read<MessageCubit>().sendMessage(SendMessageParams(
            createdAt: DateTime.now(),
            isRead: false,
            messageText: _controller.text.trim(),
            receiverId: widget.friendId,
            senderId: context.read<CurrentUserCubit>().currentUser!.id));
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.h,
              backgroundImage: NetworkImage(widget.image),
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(width: 12.w),

            // Name and City
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.friendName,
                  style: AppStyle.heading3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.category ?? '',
                  style: AppStyle.heading1.copyWith(
                    color: Colors.white70,
                    fontSize: 12.w,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        elevation: 6,
        actions: [
          PopupMenuButton<String>(
            offset: Offset(0, 55.h),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 10,
            icon: const Icon(Icons.more_vert, color: AppColors.surface),
            onSelected: (value) {
              switch (value) {
                case 'search':
                  // Implement search
                  break;
                case 'mute':
                  // Implement mute
                  break;
                case 'delete':
                  // Implement delete
                  break;
                case 'report':
                  // Implement report
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              _buildMenuItem(Icons.search, 'Search in chat', 'search'),
              _buildMenuItem(Icons.volume_off, 'Mute Notifications', 'mute'),
              _buildMenuItem(Icons.delete, 'Delete Chat', 'delete'),
              _buildMenuItem(Icons.flag, 'Report', 'report'),
            ],
          )
        ],
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
        toolbarHeight: 60.0.h,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isPatientMessage = index % 2 == 0; // Alternate messages
                return _buildMessageBubble(message, isPatientMessage);
              },
            ),
          ),
          _buildInputField(),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isPatientMessage) {
    return Align(
      alignment:
          isPatientMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isPatientMessage ? AppColors.primaryLight : AppColors.surface,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message,
          style: AppStyle.body1.copyWith(
              color: isPatientMessage ? Colors.black : AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: AppTextFormField(
              controller: _controller,
              hintText: 'Send message',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
      IconData icon, String text, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppStyle.body1.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

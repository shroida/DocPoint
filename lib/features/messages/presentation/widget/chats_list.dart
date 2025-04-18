import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/messages/presentation/pages/chat_list_screen_for_doctor_ui.dart';
import 'package:docpoint/features/messages/presentation/pages/chats_list_screen_for_patient_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});
  
  @override
  Widget build(BuildContext context) {
    bool isDoctor = context.read<CurrentUserCubit>().userType == "Doctor";
     
    return isDoctor
        ? const ChatsListScreenForPatientUI( doctorsList: [],)
        : const ChatListScreenForDoctorUI(appointments: [],);
  }
}

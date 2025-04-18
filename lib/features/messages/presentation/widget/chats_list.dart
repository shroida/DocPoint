import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/messages/presentation/pages/chat_list_screen_for_doctor_ui.dart';
import 'package:docpoint/features/messages/presentation/pages/chats_list_screen_for_patient_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsList extends StatelessWidget {
  final List<DoctorEntity> doctorList;
  final List<AppointmentEntity> appointmentList;

  const ChatsList({
    super.key,
    this.doctorList = const [],
    this.appointmentList = const [],
  });

  @override
  Widget build(BuildContext context) {
    bool isDoctor = context.read<CurrentUserCubit>().userType == "Doctor";

    return isDoctor
        ? ChatListScreenForDoctorUI(appointments: appointmentList)
        : ChatsListScreenForPatientUI(doctorsList: doctorList);
  }
}

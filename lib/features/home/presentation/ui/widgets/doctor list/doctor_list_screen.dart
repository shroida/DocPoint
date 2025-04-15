import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch doctors when screen initializes
    context.read<HomePageCubit>().getAllDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        if (state is HomePageLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomePageError) {
          return Center(child: Text(state.message));
        }

        if (state is HomePageLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Our Doctors',
                  style:
                      AppStyle.heading2.copyWith(color: AppColors.primaryDark),
                ),
              ),
              ...state.doctors.map((doctor) => DoctorCard(doctor: doctor)),
            ],
          );
        }

        return const Center(child: Text('No doctors available'));
      },
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppStyle.body2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

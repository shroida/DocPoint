import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
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
  String? _selectedCity;
  String? _selectedCategory;
  late List<String> _cities = [];
  late List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().getAllDoctors();
  }

  void _extractFilterOptions(List<DoctorEntity> doctors) {
    final cities = doctors.map((d) => d.city).whereType<String>().toSet();
    final categories =
        doctors.map((d) => d.category).whereType<String>().toSet();

    setState(() {
      _cities = cities.toList();
      _categories = categories.toList();
    });
  }

  List<DoctorEntity> _filterDoctors(List<DoctorEntity> doctors) {
    return doctors.where((doctor) {
      final cityMatch = _selectedCity == null || doctor.city == _selectedCity;
      final categoryMatch =
          _selectedCategory == null || doctor.category == _selectedCategory;
      return cityMatch && categoryMatch;
    }).toList();
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
          if (_cities.isEmpty && _categories.isEmpty) {
            _extractFilterOptions(state.doctors);
          }

          final filteredDoctors = _filterDoctors(state.doctors);

          return Column(
            children: [
              // Filter Section
              _buildFilterSection(),
              const SizedBox(height: 16),

              // Doctors List
              if (filteredDoctors.isEmpty)
                const Center(child: Text('No doctors match your filters'))
              else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Our Doctors',
                    style: AppStyle.heading2
                        .copyWith(color: AppColors.primaryDark),
                  ),
                ),
                ...filteredDoctors.map((doctor) => DoctorCard(doctor: doctor)),
              ],
            ],
          );
        }

        return const Center(child: Text('No doctors available'));
      },
    );
  }

  Widget _buildFilterSection() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filters', style: AppStyle.heading3),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // City Chips
                ..._cities.map((city) => FilterChip(
                      label: Text(city, style: AppStyle.body2),
                      selected: _selectedCity == city,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCity = selected ? city : null;
                        });
                      },
                      selectedColor: AppColors.primaryLight,
                      backgroundColor: AppColors.surface,
                      labelStyle: TextStyle(
                        color: _selectedCity == city
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    )),

                // Category Chips
                ..._categories.map((category) => FilterChip(
                      label: Text(category, style: AppStyle.body2),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                      selectedColor: AppColors.primaryLight,
                      backgroundColor: AppColors.surface,
                      labelStyle: TextStyle(
                        color: _selectedCategory == category
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    )),

                // Reset Button
                if (_selectedCity != null || _selectedCategory != null)
                  ActionChip(
                    label: Text('Reset',
                        style: AppStyle.body2.copyWith(
                          color: AppColors.primary,
                        )),
                    onPressed: () {
                      setState(() {
                        _selectedCity = null;
                        _selectedCategory = null;
                      });
                    },
                    backgroundColor: AppColors.surface,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

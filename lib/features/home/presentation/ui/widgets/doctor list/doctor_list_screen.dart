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
  List<String> _cities = [];
  List<String> _categories = [];
  bool _filtersInitialized = false;

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
      _filtersInitialized = true;
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
          if (state.doctors == null) {
            return const Center(child: Text('No doctors available'));
          }

          // Schedule filter extraction after build
          if (!_filtersInitialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _extractFilterOptions(state.doctors!);
              }
            });
          }

          final filteredDoctors = _filterDoctors(state.doctors!);

          return Column(
            children: [
              _buildFilterSection(),
              const SizedBox(height: 16),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Title Row
        const Row(
          children: [
            Icon(Icons.filter_alt_outlined, color: AppColors.primary),
            SizedBox(width: 8),
            Text('Filters', style: AppStyle.heading3),
          ],
        ),
        const SizedBox(height: 16),

        // City Filters
        const Text("Cities", style: AppStyle.heading3),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _cities.map((city) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  avatar: const Icon(Icons.location_on, size: 18),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        // Category Filters
        const Text("Categories", style: AppStyle.heading3),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory =
                          _selectedCategory == category ? null : category;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedCategory == category
                          ? Colors.white
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 7,
                          offset: const Offset(5, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.label,
                          size: 18,
                          color: _selectedCategory == category
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category,
                          style: AppStyle.body2.copyWith(
                            color: _selectedCategory == category
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // Reset Chip
        if (_selectedCity != null || _selectedCategory != null)
          Align(
            alignment: Alignment.centerLeft,
            child: ActionChip(
              avatar:
                  const Icon(Icons.refresh, size: 18, color: AppColors.primary),
              label: Text(
                'Reset',
                style: AppStyle.body2.copyWith(color: AppColors.primary),
              ),
              onPressed: () {
                setState(() {
                  _selectedCity = null;
                  _selectedCategory = null;
                });
              },
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
      ]),
    );
  }
}

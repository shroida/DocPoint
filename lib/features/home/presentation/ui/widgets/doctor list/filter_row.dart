import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class FilterChipsRow extends StatelessWidget {
  final List<String> list;
  final String? selectedlist;
  final Function(String?) onSelected;

  const FilterChipsRow({
    super.key,
    required this.list,
    required this.selectedlist,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: list.map((list) {
        final isSelected = selectedlist == list;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              onSelected(isSelected ? null : list);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : AppColors.surface,
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
                    color: isSelected ? AppColors.primary : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    list,
                    style: AppStyle.body2.copyWith(
                      color: isSelected
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
    );
  }
}

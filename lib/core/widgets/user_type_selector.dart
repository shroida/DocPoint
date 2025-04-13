import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTypeSelector<T extends Cubit<U>, U> extends StatelessWidget {
  final String Function(U state) getUserType;
  final void Function(String) setUserType;
  final List<String> userTypes;

  const UserTypeSelector({
    super.key,
    required this.getUserType,
    required this.setUserType,
    this.userTypes = const ['Patient', 'Doctor'],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select User Type',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          BlocBuilder<T, U>(
            builder: (context, state) {
              final currentType = getUserType(state);
              return Wrap(
                spacing: 8.0,
                children: userTypes.map((String type) {
                  final isSelected = currentType == type;
                  return ChoiceChip(
                    checkmarkColor: Colors.white,
                    label: Text(type),
                    selected: isSelected,
                    selectedColor: const Color(0xff0064FA),
                    backgroundColor: const Color(0xffF0EFFF),
                    labelStyle: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xff0064FA),
                      fontFamily: 'Poppins',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xff0064FA)
                            : const Color(0xff0064FA),
                        width: 2.0,
                      ),
                    ),
                    onSelected: (bool selected) {
                      setUserType(selected ? type : userTypes.first);
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

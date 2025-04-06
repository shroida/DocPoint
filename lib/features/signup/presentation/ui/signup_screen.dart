import 'package:docpoint/features/signup/presentation/ui/widgets/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  String userType = 'Patient';
  String city = 'Giza';
  String category = 'Dentist';

  bool isPasswordObscureText = true;
  final List<String> cities = [
    'Giza',
    'Cairo',
    'Alexandria',
    'hurghada',
    'Suez'
  ];
  final List<String> categories = [
    'Dentist',
    'Cardiologist',
    'General Physician',
    'Pediatrician',
    'Orthopedist',
    'Internist',
    'Surgeon',
    'ENT Specialist',
    'Dermatologist'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Register',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PickImage(),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select User Type',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: ['Patient', 'Doctor'].map((String type) {
                            final isSelected = userType == type;
                            return ChoiceChip(
                              checkmarkColor: Colors.white,
                              label: Text(type),
                              selected: isSelected,
                              selectedColor: const Color(0xff0064FA),
                              backgroundColor: const Color(0xffF0EFFF),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xff0064FA),
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
                                setState(() {
                                  userType = selected ? type : 'Patient';
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ]),
          ),
        )));
  }
}

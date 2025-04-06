import 'dart:io';
import 'package:docpoint/core/widgets/app_dropdown_form_field.dart';
import 'package:docpoint/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  String userType = 'Patient';
  String city = 'Giza';
  String category = 'Dentist';

  XFile? _imageFile;
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

  final Location _location = Location();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
        );
      }
    }
  }

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
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _imageFile != null
                            ? Image.file(
                                File(_imageFile!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: const Color(0xffF0EFFF),
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey.shade600,
                                    size: 30,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
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
                  AppTextFormField(
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                      hintText: 'Password',
                      isObscureText: isPasswordObscureText,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordObscureText = !isPasswordObscureText;
                          });
                        },
                        child: Icon(
                          isPasswordObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Password';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                      hintText: 'First name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid first name';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                      hintText: 'Last name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid last name';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                      hintText: 'Phone number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid phone number';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  AppDropdownFormField<String>(
                    hintText: 'Select your city',
                    value: city,
                    items: cities.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        city = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your city';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (userType == 'Doctor')
                    AppDropdownFormField<String>(
                      hintText: 'Select your category',
                      value: category,
                      items: categories.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          category = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your category';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (userType == 'Doctor')
                    AppTextFormField(
                        hintText: 'Experience',
                        validator: (value) {
                          if (value == null || value.isEmpty) {}
                        }),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
          ),
        )));
  }
}

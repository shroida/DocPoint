import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String userType = 'Patient';
  String email = '';
  String password = '';
  String phoneNumber = '';
  String firstName = '';
  String lastName = '';
  String city = 'Guwahati';
  String profileImageUrl = '';
  String category = 'Dentist';
  String qualification = '';
  String yearsOfExperience = '';
  double latitude = 0.0;
  double longitude = 0.0;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final Location _location = Location();
  bool _isLoading = false;
  bool _obscureText = true;
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
                      onTap: () {},
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
                ]),
          ),
        )));
  }
}

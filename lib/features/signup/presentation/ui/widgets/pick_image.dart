import 'dart:io';

import 'package:docpoint/features/signup/presentation/logic/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Center(
      child: GestureDetector(
        onTap: () async {
          final pickedFile = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 800,
            maxHeight: 800,
            imageQuality: 80,
          );
          if (pickedFile != null) {
            setState(() {
              cubit.imageFile = File(pickedFile.path);
            });
          }
        },
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            final imageFile = cubit.imageFile;
            return ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imageFile != null
                  ? Image.file(
                      imageFile,
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
            );
          },
        ),
      ),
    );
  }
}

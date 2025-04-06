import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';

class PickImage extends StatelessWidget {
  PickImage({
    super.key,
  });
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.read<SignupCubit>().pickImage();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: imageFile != null
              ? Image.file(
                  File(imageFile!.path),
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
    );
  }
}

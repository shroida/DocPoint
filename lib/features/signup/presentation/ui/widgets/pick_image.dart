import 'dart:io';

import 'package:docpoint/core/utlis/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';

class PickImage extends StatefulWidget {
  const PickImage({
    super.key,
  });

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    final imageFile = context.read<SignupCubit>().imageFile;
    return Center(
      child: GestureDetector(
        onTap: () async {
          final pickedImage = await pickImage();
          if (pickedImage != null) {
            setState(() {
              context.read<SignupCubit>().imageFile = pickedImage;
            });
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: imageFile != null
              ? Image.file(
                  File(imageFile.path),
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

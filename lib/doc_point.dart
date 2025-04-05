import 'package:flutter/material.dart';

class DocPoint extends StatelessWidget {
  const DocPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Text('Doc Point'),
      ),
    );
  }
}

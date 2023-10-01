import 'dart:io';

import 'package:flutter/material.dart';

class FileImageView extends StatelessWidget {
  final String path;
  const FileImageView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.file(File(path))),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String photourl;
  const PhotoViewPage({super.key, required this.photourl});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(photourl),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UploadRecumeView extends StatefulWidget {
  final String? url;
  const UploadRecumeView({super.key, this.url});

  @override
  State<UploadRecumeView> createState() => _UploadRecumeViewState();
}

class _UploadRecumeViewState extends State<UploadRecumeView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.black,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url!,
        key: _pdfViewerKey,
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class PdfHelper {
  Future<void> saveAsFile({
    BuildContext? context,
    LayoutCallback? build,
    PdfPageFormat? pageFormat,
  }) async {
    final bytes = await build!(pageFormat!);
    if (await Permission.storage.request().isGranted) {
      final appDocDir = await DownloadsPath.downloadsDirectory();
      final appDocPath = appDocDir!.path;
      final file = File(appDocPath + '/' + 'bringin_payment_receipt.pdf');
      print('Save as file ${file.path} ...');
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(content: Text("File saved in ${file.path}")));
      await file.writeAsBytes(bytes);
      print(file.path);
      await OpenFile.open(file.path);
    } else {
      await Permission.storage.request();
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text("Need Storage permission for download this receipt")));
    }
  }
}

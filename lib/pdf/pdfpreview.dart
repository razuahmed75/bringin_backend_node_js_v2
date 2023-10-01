// // ignore_for_file: public_member_api_docs

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:attendence/Pdf/payslip.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// import '../Controller/personal.dart';
// import '../Model/salary.dart';

// class PdfPreviewPage extends StatefulWidget {
//   final Personalcontroller personalcontroller;
//   final Salary data;
//   const PdfPreviewPage(
//       {super.key, required this.personalcontroller, required this.data});

//   @override
//   State<PdfPreviewPage> createState() => _PdfPreviewPageState();
// }

// class _PdfPreviewPageState extends State<PdfPreviewPage> {
//   final actions = <PdfPreviewAction>[
//     if (!kIsWeb)
//       PdfPreviewAction(
//         onPressed: (context, build, pageFormat) {},
//         icon: const Icon(Icons.save),
//       )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//           ),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   _saveAsFile(
//                       build: (format) => generateDocument(PdfPageFormat.a4,
//                           widget.personalcontroller, widget.data),
//                       context: context,
//                       pageFormat: PdfPageFormat.a4);
//                 },
//                 icon: Icon(
//                   Icons.save,
//                   color: Colors.white,
//                 ))
//           ],
//           title: Text(
//             "Payslip",
//             style: TextStyle(color: Colors.white),
//           )),
//       body: PdfPreview(
//         build: (format) => generateDocument(
//             PdfPageFormat.a4, widget.personalcontroller, widget.data),
//         useActions: false,
//       ),
//     );
//   }

//   void _showPrintedToast(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Document printed successfully'),
//       ),
//     );
//   }

//   void _showSharedToast(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Document shared successfully'),
//       ),
//     );
//   }

//   Future<void> _saveAsFile({
//     BuildContext? context,
//     LayoutCallback? build,
//     PdfPageFormat? pageFormat,
//   }) async {
//     final bytes = await build!(pageFormat!);

//     final appDocDir = await getApplicationDocumentsDirectory();
//     final appDocPath = appDocDir.path;
//     final file = File(appDocPath + '/' + 'document.pdf');
//     print('Save as file ${file.path} ...');
//     ScaffoldMessenger.of(context!)
//         .showSnackBar(SnackBar(content: Text("Save as file ${file.path} ...")));
//     await file.writeAsBytes(bytes);
//     await OpenFile.open(file.path);
//   }
// }

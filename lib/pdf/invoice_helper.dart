import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/Package/payment_history_model.dart';
import '../res/dimensions.dart';

Future<Uint8List> generateDocument(PdfPageFormat format, final PaymentHistoryModel? data) async {
  final doc = pw.Document(pageMode: PdfPageMode.outlines);
  final regular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
  final regularbold = await rootBundle.load("assets/fonts/Roboto-Medium.ttf");

  final font1 = pw.Font.ttf(regular);
  final font2 = pw.Font.ttf(regularbold);

  // final profileImage = pw.MemoryImage(
  //   (await rootBundle.load('Asstes/vaani-4.png')).buffer.asUint8List(),
  // );

  // final shape = await rootBundle.loadString('assets/document.svg');
  // final swirls = await rootBundle.loadString('assets/swirls2.svg');

  doc.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: format.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        theme: pw.ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
      ),
      build: (context) {
        return pw.Padding(
          padding:  pw.EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            bottom: 20.h,
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 15.h),
              /// PAYMENT RECEIPT
              Payment_Receipt(),
              pw.SizedBox(height: 15.h),

              /// BILLING INFORMATION
              Billing_info_Section(data),
              pw.SizedBox(height: 15.h),

              /// DESCRIPTION AND AMOUNT
              Description_And_Amount(data),
              pw.SizedBox(height: 15.h),

              /// TRANSACTION INFO
              Transaction_info(data),
              pw.SizedBox(height: 20.h),

              /// NOTES
              Notes(),
            ],
          ),
        );
      },
    ),
  );

  return await doc.save();
  
}
  pw.Widget  Notes() {
    return pw.RichText(text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: 'Notes: ',
                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)
                ),
                pw.TextSpan(
                  text: 'To learn more about our payment policies, please ',
                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal),
                ),
                pw.TextSpan(
                  text: 'click here ',
                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold,color: PdfColor.fromHex("#0077B5")),
                ),
                pw.TextSpan(
                  text: 'and refer to the "Package Deals" section.',
                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal),
                ),
              ]
            ));
  }

  pw.Widget Transaction_info(data) {
    return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text("Bank Trx ID",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),),
                pw.Text(":",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 5.w),
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(
                    data!.transactionID!.bankTrxid ?? "",
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                    style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
              ],
            ),
            pw.SizedBox(height: 7.h),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text("Payment Method",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),),
                pw.Text(":",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 5.w),
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(
                    data!.transactionID!.paymentType ?? "",
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                    style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
              ],
            ),
            pw.SizedBox(height: 7.h),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text("Card No",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Text(":",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 5.w),
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(
                    data!.transactionID!.cardnumber ?? "",
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                    style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
              ],
            ),
            pw.SizedBox(height: 7.h),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text("Payment Date",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Text(":",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 5.w),
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(
                    data!.transactionID!.date!.split(" ").first,
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                    style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
              ],
            ),
              ],
            );
  }

  pw.Widget Description_And_Amount(data) {
    return pw.Table(
              border: pw.TableBorder.all(width: 1, color: PdfColor.fromHex("#E8E8E8")),
              children: [
                /// first row
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F8F8"),
                  ),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8.w,vertical: 3.h),
                      child: pw.Text("Description",style: pw.TextStyle(
                          fontSize: 16.sp, fontWeight: pw.FontWeight.bold),
                    )),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(3.h),
                      child: pw.Center(child: pw.Text("Amount",style: pw.TextStyle(
                          fontSize: 16.sp, fontWeight: pw.FontWeight.bold))),
                    ),
                  ]
                ),

                /// second row
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F8F8"),
                  ),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8.w,vertical: 3.h),
                      child: pw.Text("${data!.packageid!.name} Package",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(3.h),
                      child: pw.Center(child: pw.Text(data!.transactionID!.recAmount.toString()+" TK",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
                    ),
                  ],
                ),

                /// third row
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F8F8"),
                  ),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8.w,vertical: 3.h),
                      child: pw.Text("Discount",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(3.h),
                      child: pw.Center(child: pw.Text("0.00 TK",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
                    ),
                  ],
                ),

                /// fourth row
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F8F8"),
                  ),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8.w,vertical: 3.h),
                      child: pw.Text("VAT & TAX",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(3.h),
                      child: pw.Center(child: pw.Text(data!.transactionID!.processingCharge.toString()+" TK",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal))),
                    ),
                  ],
                ),

                /// fifth row
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F8F8"),
                  ),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8.w,vertical: 3.h),
                      child: pw.Text("Total Paid",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(3.h),
                      child: pw.Center(child: pw.Text(data!.packageid!.amount.toString()+" TK",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold))),
                    ),
                  ],
                ),
              ],
            );
  }

  pw.Widget Payment_Receipt() {
    return pw.Container(
              padding: pw.EdgeInsets.symmetric(vertical: 8.h),
              width: double.maxFinite,
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex("#F3F3F3"),
              ),
              child: pw.Text("Payment Receipt",style: pw.TextStyle(
                          fontSize: 22.sp, fontWeight: pw.FontWeight.bold),),
            );
  }

  pw.Widget Billing_info_Section(data) {
    return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Billing Information",style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 4.h),
                        
                        pw.Container(
                          // color: Colors.amber,
                          width: Dimensions.screenWidth*.65,
                          child: pw.Row(
                            children: [
                              pw.Text(
                                 "Name",
                                style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 10.w),
                              pw.Text(
                                 ":",
                                style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 10.w),
                              pw.Expanded(
                                child: pw.Text(
                                 data!.recruiterid!.firstname!+" "+data!.recruiterid!.lastname!,
                                 maxLines: 1,
                                 overflow: pw.TextOverflow.clip,
                                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 7.h),
                        pw.Container(
                          // color: Colors.amber,
                          width: Dimensions.screenWidth*.65,
                          child: pw.Row(
                            children: [
                              pw.Text(
                                 "Mobile",
                                style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 4.w),
                              pw.Text(
                                 ":",
                                style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 5.w),
                              pw.Expanded(
                                child: pw.Text(
                                 data!.recruiterid!.number!,
                                 maxLines: 1,
                                   overflow: pw.TextOverflow.clip,
                                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 7.h),
                        pw.Container(
                          // color: Colors.amber,
                          width: Dimensions.screenWidth*.65,
                          child: pw.Row(
                            children: [
                              pw.Text(
                                 "Email",
                                style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 10.w),
                              pw.Text(
                                 " :",
                                style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 5.w),
                              pw.Expanded(
                                child: pw.Text(
                                 data!.recruiterid!.email!,
                                 maxLines: 1,
                                   overflow: pw.TextOverflow.clip,
                                  style: pw.TextStyle(
                          fontSize: 14.sp, fontWeight: pw.FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(horizontal: width(12),vertical: height(6)),
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex("#0077B5"),
                        borderRadius: pw.BorderRadius.circular(17.r),
                      ),
                      child: pw.Text("Paid",style: pw.TextStyle(
                          fontSize: 16.sp, fontWeight: pw.FontWeight.bold,color: PdfColor.fromHex("#FFFFFF"))),
                    ),
                  ],
                ),
              ],
            );
  }


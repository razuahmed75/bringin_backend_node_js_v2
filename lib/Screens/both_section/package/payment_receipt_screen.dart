

import 'package:bringin/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pdf/pdf.dart';
import '../../../models/Package/payment_history_model.dart';
import '../../../pdf/invoice_helper.dart';
import '../../../pdf/pdf_helper.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final PaymentHistoryModel? data;
  const PaymentReceiptScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            children: [
              const Gap(50),
              /// PAYMENT RECEIPT
              Payment_Receipt(),
              const Gap(15),

              /// BILLING INFORMATION
              Billing_info_Section(),
              const Gap(15),

              /// DESCRIPTION AND AMOUNT
              Description_And_Amount(),
              const Gap(15),

              /// TRANSACTION INFO
              Transaction_info(),
              const Gap(20),

              /// NOTES
              Notes(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async{
        await PdfHelper().saveAsFile(
          build: (format) => generateDocument(PdfPageFormat.a4,data),
          context: context,
          pageFormat: PdfPageFormat.a4);
        },
        child: Container(
          padding: Dimensions.kDefaultPadding,
          height: height(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImagePaths.download_icon,height: height(25)),
              const Gap(10),
              Text("Download Receipt as PDF",style: Styles.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  RichText Notes() {
    return RichText(text: TextSpan(
              children: [
                TextSpan(
                  text: 'Notes: ',
                  style: Styles.bodySmall.copyWith(color: AppColors.blackColor)
                ),
                TextSpan(
                  text: 'To learn more about our payment policies, please ',
                  style: Styles.bodySmall1,
                ),
                TextSpan(
                  text: 'click here ',
                  style: Styles.bodySmall.copyWith(color: AppColors.mainColor),
                ),
                TextSpan(
                  text: 'and refer to the "Package Deals" section.',
                  style: Styles.bodySmall1,
                ),
              ]
            ));
  }

  Column Transaction_info() {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Bank Trx ID",style: Styles.bodySmall.copyWith(color: AppColors.blackColor))),
                Text(":",style: Styles.bodySmall),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 8,
                  child: Text(
                    data!.transactionID!.bankTrxid ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall1.copyWith(color: AppColors.blackColor.withOpacity(.8)),)),
              ],
            ),
            SizedBox(height: 7.w),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Payment Method",style: Styles.bodySmall.copyWith(color: AppColors.blackColor))),
                Text(":",style: Styles.bodySmall),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 8,
                  child: Text(
                    data!.transactionID!.paymentType ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall1.copyWith(color: AppColors.blackColor.withOpacity(.8)),)),
              ],
            ),
            SizedBox(height: 7.w),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Card No",style: Styles.bodySmall.copyWith(color: AppColors.blackColor))),
                Text(":",style: Styles.bodySmall),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 8,
                  child: Text(
                    data!.transactionID!.cardnumber ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall1.copyWith(color: AppColors.blackColor.withOpacity(.8)),)),
              ],
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Payment Date",style: Styles.bodySmall.copyWith(color: AppColors.blackColor))),
                Text(":",style: Styles.bodySmall),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 8,
                  child: Text(
                    data!.transactionID!.date!.split(" ").first,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall1.copyWith(color: AppColors.blackColor.withOpacity(.8)),)),
              ],
            ),
              ],
            );
  }

  Table Description_And_Amount() {
    return Table(
              border: TableBorder.all(width: 1, color: AppColors.shadowColor),
              children: [
                /// first row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(8),vertical: height(3)),
                      child: Text("Description",style: Styles.bodyMedium),
                    ),
                    Padding(
                      padding: EdgeInsets.all(height(3)),
                      child: Center(child: Text("Amount",style: Styles.bodyMedium)),
                    ),
                  ]
                ),

                /// second row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(8),vertical: height(3)),
                      child: Text("${data!.packageid!.name} Package",style: Styles.bodySmall1),
                    ),
                    Padding(
                      padding: EdgeInsets.all(height(3)),
                      child: Center(child: Text("৳"+data!.transactionID!.recAmount.toString(),style: Styles.bodySmall1)),
                    ),
                  ],
                ),

                /// third row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(8),vertical: height(3)),
                      child: Text("Discount",style: Styles.bodySmall1),
                    ),
                    Padding(
                      padding: EdgeInsets.all(height(3)),
                      child: Center(child: Text("৳0.00",style: Styles.bodySmall1)),
                    ),
                  ],
                ),

                /// fourth row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(8),vertical: height(3)),
                      child: Text("VAT & TAX",style: Styles.bodySmall1),
                    ),
                    Padding(
                      padding: EdgeInsets.all(height(3)),
                      child: Center(child: Text("৳"+data!.transactionID!.processingCharge.toString(),style: Styles.bodySmall1)),
                    ),
                  ],
                ),

                /// fifth row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(8),vertical: height(3)),
                      child: Text("Total Paid",style: Styles.bodySmall.copyWith(color: AppColors.blackColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(height(3)),
                      child: Center(child: Text("৳"+data!.packageid!.amount.toString(),style: Styles.bodySmall.copyWith(color: AppColors.blackColor))),
                    ),
                  ],
                ),
              ],
            );
  }

  Container Payment_Receipt() {
    return Container(
              padding: EdgeInsets.symmetric(vertical: height(8)),
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFF3F3F3),
              ),
              child: Text("Payment Receipt",style: Styles.smallTitle,),
            );
  }

  Column Billing_info_Section() {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Billing Information",style: Styles.bodySmall.copyWith(
                          color: AppColors.blackColor,
                        )),
                        const Gap(4),
                        
                        Container(
                          // color: Colors.amber,
                          width: Dimensions.screenWidth*.65,
                          child: Row(
                            children: [
                              Text(
                                 "Name",
                                style: Styles.bodySmall.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                 ":",
                                style: Styles.bodySmall.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Text(
                                 data!.recruiterid!.firstname!+" "+data!.recruiterid!.lastname!,
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                                  style: Styles.bodySmall1.copyWith(
                                    color: AppColors.blackColor.withOpacity(.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(7),
                        Container(
                          // color: Colors.amber,
                          width: Dimensions.screenWidth*.65,
                          child: Row(
                            children: [
                              Text(
                                 "Mobile",
                                style: Styles.bodySmall.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(5),
                              Text(
                                 ":",
                                style: Styles.bodySmall.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(5),
                              Expanded(
                                child: Text(
                                 data!.recruiterid!.number!,
                                 maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                  style: Styles.bodySmall1.copyWith(
                                    color: AppColors.blackColor.withOpacity(.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(7),
                        Container(
                          // color: Colors.amber,
                          width: Dimensions.screenWidth*.65,
                          child: Row(
                            children: [
                              Text(
                                 "Email",
                                style: Styles.bodySmall.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                 " :",
                                style: Styles.bodySmall.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(5),
                              Expanded(
                                child: Text(
                                 data!.recruiterid!.email!,
                                 maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                  style: Styles.bodySmall1.copyWith(
                                    color: AppColors.blackColor.withOpacity(.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(12),vertical: height(6)),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(radius(17)),
                      ),
                      child: Text("Paid",style: Styles.bodyMedium.copyWith(color: AppColors.whiteColor)),
                    ),
                  ],
                ),
              ],
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImagePaths.appLogoIcon,
                height: height(55),
                width: height(55),
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("bringin",style: Styles.largeTitle.copyWith(
                    color: AppColors.mainColor,
                  ),),
                  Text("Instant Chat - Hire Direct",style: Styles.smallText.copyWith(
                    color: AppColors.mainColor,
                  ),)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

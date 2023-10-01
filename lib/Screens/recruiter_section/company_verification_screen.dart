import 'dart:io';

import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../controllers/upload_file/upload_recruiter_document.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/strings.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/routes/route_helper.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../widgets/file_uploader_widget.dart';
import '../../../../widgets/re_upload_button.dart';
import '../../Hive/hive.dart';
import '../../utils/services/keys.dart';
import '../../widgets/need_help_widget.dart';

class CompanyVerificationScreen extends StatelessWidget {
  const CompanyVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UploadRecruiterDocumentController uploadDocumentController =
        Get.find<UploadRecruiterDocumentController>();
    return Scaffold(
      appBar:
          appBarWidget(
            title: "", 
            onBackPressed: () => Get.back(), 
            actions: [
              NeedHelpWidget(),
              const Gap(20),
            ]
          ),
      bottomNavigationBar: SafeArea(
        child: ColoredBox(
          color: AppColors.whiteColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Text(
                  AppStrings.verifyDocumentPageDes,
                  style: Styles.bodyMedium2,
                ),
              ),
              const Gap(20),
              Container(
                width: double.maxFinite,
                child: Obx(
                  () => BottomNavWidget(
                    text: uploadDocumentController.isLoading.value
                        ? "Processing..."
                        : "Next",
                    onTap: uploadDocumentController.isLoading.value ? null : () async {
                      if (uploadDocumentController.result != null) {
                        await uploadDocumentController.postCompanyVerify(
                          imgpath: uploadDocumentController.fileExtension ==
                                  '.pdf'
                              ? uploadDocumentController.compressedPdf!.path
                              : uploadDocumentController.compressedImage!.path,
                        );
                        if (uploadDocumentController.isBack.value == true) {
                          Get.toNamed(
                              RouteHelper.getRecruiterIdentityVerifyRoute());
                        }
                        return null;
                      } else {
                        Helpers().showToastMessage(
                          msg: "Please select a document first",
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,

              /// verify your company
              Text("Verify your company", style: Styles.smallTitle),
              const Gap(3),
              Text(
                "Upload one of the below documents to verify your company.",
                style: Styles.bodyMedium2,
              ),
              const Gap(30),

              Text("1. Certificate of Incorporation",
                  style: Styles.bodyMedium1),
              const Gap(5),
              Text("2. BIN Certificate", style: Styles.bodyMedium1),
              const Gap(5),
              Text("3. Trade License", style: Styles.bodyMedium1),
              const Gap(5),
              Text("4. Other Authorized Documents", style: Styles.bodyMedium1),
              const Gap(25),

              /// uploader field
              GetBuilder<UploadRecruiterDocumentController>(builder: (_) {
                return uploadDocumentController.result == null
                    ? FileUploaderWidget(
                        onUploadPressed: () {
                          uploadDocumentController.uploadDocument();
                          print(HiveHelp.read(Keys.authToken));
                        }
                            ,
                      )
                    : SizedBox.shrink();
              }),

              /// SHOWING PDF OR IMAGE PREVIEW BEFORE UPLOADING
              GetBuilder<UploadRecruiterDocumentController>(builder: (_) {
                if (uploadDocumentController.result != null &&
                    uploadDocumentController.fileExtension == '.pdf') {
                  return Center(
                    child: Container(
                      height: height(280),
                      width: Dimensions.screenWidth - 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: SfPdfViewer.file(
                        uploadDocumentController.renamedFile!),
                    ),
                  );
                } else if (uploadDocumentController.result != null &&
                    uploadDocumentController.fileExtension != '.pdf') {
                  return Center(
                    child: Container(
                      height: height(280),
                      width: Dimensions.screenWidth - 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Image.file(
                        File(uploadDocumentController.renamedFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              }),

              GetBuilder<UploadRecruiterDocumentController>(builder: (_) {
                return uploadDocumentController.result == null
                    ? SizedBox.shrink()
                    : ReUploadButton(
                        onTap: () {
                          uploadDocumentController.resetImagePickerResult();
                          uploadDocumentController.uploadDocument();
                        },
                      );
              }),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

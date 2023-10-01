import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../../../controllers/upload_file/upload_recruiter_document.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/color.dart';
import '../../../../../../res/constants/strings.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../utils/routes/route_helper.dart';
import '../../../../../../utils/services/helpers.dart';
import '../../../../../../widgets/app_bar.dart';
import '../../../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../../../widgets/file_uploader_widget.dart';
import '../../../../../../widgets/re_upload_button.dart';

class AuthorizedDocVerifyScreen extends StatelessWidget {
  const AuthorizedDocVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UploadRecruiterDocumentController uploadDocumentController =
        Get.find<UploadRecruiterDocumentController>();
    return Scaffold(
      appBar:
          appBarWidget(title: "", onBackPressed: () => Get.back(), actions: []),
      
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,
            Text("Any Other Authorized Document",
                    style: Styles.smallTitle),
            const Gap(3),
            Text(
              AppStrings.authorizedDocVerifyDes,
              style: Styles.subTitle,
            ),
            const Gap(50),

            /// uploader field
            GetBuilder<UploadRecruiterDocumentController>(builder: (_) {
              return uploadDocumentController.result == null
                  ? FileUploaderWidget(
                      onUploadPressed: () =>
                          uploadDocumentController.uploadDocument(),
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

            /// RE-UPLOAD BUTTON
            GetBuilder<UploadRecruiterDocumentController>(builder: (_) {
              return uploadDocumentController.result == null
                  ? SizedBox.shrink()
                  : ReUploadButton(onTap: () {
                      uploadDocumentController.resetImagePickerResult();
                      uploadDocumentController.uploadDocument();
                    });
            }),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavWidget(
          text: uploadDocumentController.isLoading.value
              ? "Processing..."
              : "Submit",
          onTap: uploadDocumentController.isLoading.value ? null : () async {
            if (uploadDocumentController.result != null) {
              await uploadDocumentController.postCompanyVerify(
                isCompanyVerify: false,
                type: "6",
                path: uploadDocumentController.fileExtension == '.pdf'
                    ? uploadDocumentController.compressedPdf!.path
                    : uploadDocumentController.compressedImage!.path,
              );
              if (uploadDocumentController.isBack.value == true) {
                Get.toNamed(
                  RouteHelper.getUnderVerificationRoute(),
                  arguments: ["documents", false],
                );
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
    );
  }
}

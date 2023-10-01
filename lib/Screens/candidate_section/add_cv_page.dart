
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../controllers/upload_file/upload_recruiter_document.dart';
import '../../../../res/app_font.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/constants/strings.dart';
import '../../../../res/dimensions.dart';
import '../../res/color.dart';
import '../../utils/services/helpers.dart';


class AddCvScreen extends StatelessWidget {
  const AddCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UploadRecruiterDocumentController uploadDocumentController = Get.find<UploadRecruiterDocumentController>();
    return Scaffold(
      appBar: appBarWidget(
        title: "Add your CV",
        onBackPressed: () => Get.back(),
        actions: [],
      ),
      body: Container(
        margin: Dimensions.kDefaultPadding,
        decoration: BoxDecoration(
           color: AppColors.whiteColor,
           borderRadius: BorderRadius.circular(radius(9)),
        ),
        child: Column(
          children: [

            // description
            Text(AppStrings.addCvDes, style: Styles.subTitle.copyWith(fontSize: font(15)),textAlign: TextAlign.center,),
            const Gap(60),

            // upload from mobile
            _UploadButton(
              onTap: () {
                uploadDocumentController.uploadResume();
              },
              iconPath: AppImagePaths.mobileIcon,
              text: "Upload From Device",
            ),
            const Gap(25),
            Obx((){
              if(  isUploadingResume.value){
                return Center(
                  child: Helpers.appLoader2(),
                );
              }
              return SizedBox();
            }),
            Expanded(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImagePaths.privacyIcon,
                  height: height(20),
                  width: height(24),
                ),
                const Gap(15),
                SizedBox(
                    width: Dimensions.screenWidth * .8,
                    child: Text(AppStrings.addCvDes2,
                        style: Styles.bodySmall2)),
              ],
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }
  Widget _UploadButton({
    void Function()? onTap,
    String? iconPath,text,
  }){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius(6)),
        child: Container(
          width: width(200),
          height: height(100),
          padding: EdgeInsets.symmetric(vertical: height(12)),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 0.25, color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(radius(6)),
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                iconPath!,
                height: height(38),
                width: height(38),
              ),
              Spacer(),
              Text(text, style: Styles.bodyMedium1),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../res/app_font.dart';
import '../../res/constants/strings.dart';
import '../../res/dimensions.dart';
import '../../utils/routes/route_helper.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_bottom_nav_widget.dart';
import '../../widgets/file_uploader_widget.dart';

class DocumentVerificationPage extends StatelessWidget {
  const DocumentVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      appBarWidget(title: "", onBackPressed: () => Get.back(), actions: []),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,
              /// verify your company
              Text("Verify with your company", style: Styles.smallTitle),
              Text("Upload one of the below documents to verify your company",style: Styles.subTitle,),
              const Gap(30),
              Text("1. Certificate of Incorporation",style: Styles.bodyMedium1),
              const Gap(5),
              Text("2. BIN Certificate", style: Styles.bodyMedium1),
              const Gap(5),
              Text("3. Trade License", style: Styles.bodyMedium1),
              const Gap(5),
              Text("4. Other Authorized Documents", style: Styles.bodyMedium1),
              const Gap(25),
              /// uploader field
              FileUploaderWidget(
                onUploadPressed: () {
                  print(" sgkjdfhjkdfhgkjdf");
                  // UploadrecriterProfileAndDoc().uploadRecruiterDoc();
                }
              ),
              Gap(25),
              Text(
                AppStrings.verifyDocumentPageDes,
                style: Styles.bodySmall3,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavWidget(
        text: "Submit",
        onTap: () => Get.toNamed(
          RouteHelper.getRecruiterIdentityVerifyRoute(),
        ),
      ),
    );
  }
}

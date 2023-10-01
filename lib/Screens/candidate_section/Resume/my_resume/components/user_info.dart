import 'package:bringin/res/color.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/bindings/bindings_controllers_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:time_machine/time_machine.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../widgets/app_bar.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key});
  final MyResumeController myResumeController = Get.put(MyResumeController());
  CandidateMainProfileController candidateMainProfileController =
      Get.put(CandidateMainProfileController());
  CandidateEditMainProfileController candidateEditMainProfileController =
      Get.find<CandidateEditMainProfileController>();

  int differentedu(DateTime date1, DateTime date2) {
    LocalDate a = LocalDate.dateTime(date1);
    LocalDate b = LocalDate.dateTime(date2);
    Period diff = b.periodSince(a);
    return diff.years;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<CandidateEditMainProfileController>(builder: (_) {
          return GestureDetector(
            onTap: _.profileInfoList[0].image == null
                ? null
                : () {
              Get.to(()=>Scaffold(
                backgroundColor: AppColors.blackColor,
                appBar: appBarWidget(
                  title: "1/1",
                  bgColor: AppColors.whiteColor,
                  onBackPressed: ()=> Get.back(),
                  actions: [],
                ),
                body: Center(
                child: PhotoView(
                  imageProvider: NetworkImage(_.profileInfoList[0].image == null
                          ? "https://www.w3schools.com/howto/img_avatar.png"
                          : AppConstants.imgurl + _.profileInfoList[0].image!)),
              )));
                  },
            child: ClipOval(
              child: Container(
                height: height(65),
                width: height(65),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: _.profileInfoList[0].image == null
                ? Image.asset(AppImagePaths.profile,fit: BoxFit.cover,)
                : CachedNetworkImage(
                          imageUrl: AppConstants.imgurl + _.profileInfoList[0].image!,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, stackTrace) => Icon(Icons.error,size: height(65)),
                        ),
              ),
            ),
          );
        }),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<CandidateEditMainProfileController>(
              builder: (controller) {
                return Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width*.6,
                      ),
                      child: Text(
                        controller.profileInfoList[0].fastname == null 
                        || controller.profileInfoList[0].lastname == null ? 
                        "" : controller.profileInfoList[0].fastname! +
                            " " +
                            controller.profileInfoList[0].lastname!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.largeTitle,
                      ),
                    ),
                    const Gap(10),
                    // edit icon
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () => Get.toNamed(
                            RouteHelper.getCandidateEditMainProfileRoute()),
                        icon: SvgPicture.asset(
                          AppImagePaths.profile_edit,
                          height: height(22),
                          width: height(22),
                        )),
                  ],
                );
              },
            ),
            const Gap(5),

            /// years, age, education degree
            Container(
              constraints: BoxConstraints(
                minWidth: Dimensions.screenWidth * .63,
                maxWidth: Dimensions.screenWidth * .66,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconAndText(
                    iconPath: AppImagePaths.durationIcon,
                    iconSize: height(17),
                    text: myResumeController.myresume!.education!.isEmpty
                        ? ""
                        : "${differentedu(myResumeController.myresume!.education![0].startdate!, myResumeController.myresume!.education![0].enddate!)} Years",
                  ),
                  IconAndText(
                    iconPath: AppImagePaths.graduateIcon,
                    textWidth: Dimensions.screenWidth * .14,
                    text: myResumeController.myresume!.education!.isEmpty
                        ? ""
                        : myResumeController
                            .myresume!.education![0].digree == null ? "" : myResumeController
                            .myresume!.education![0].digree!.name ?? "",
                  ),
                  IconAndText(
                    iconPath: AppImagePaths.ageIcon,
                    text: myResumeController.myresume!.education!.isEmpty
                        ? ""
                        : "${different(myResumeController.myresume!.userid!.deatofbirth!)} Years",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  int different(DateTime date2) {
    DateTime date1 = DateTime.now();
    int year = date1.difference(date2).inDays;
    return year ~/ 365;
  }

  Widget IconAndText({
    final String? iconPath,
    final double? iconSize,
    final String? text,
    final textWidth = null,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath!,
          height: iconSize ?? height(23),
          width: iconSize ?? height(23),
        ),
        const Gap(5),
        Container(
            width: textWidth,
            child: Text(
              text!,
              style: Styles.bodySmall2.copyWith(
                color: AppColors.blackOpacity70,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }
}

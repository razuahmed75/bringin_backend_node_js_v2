import 'package:bringin/res/constants/strings.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return Scaffold(
      appBar: appBarWidget(
        title: "Bringin - Privacy Policy",
        titleSize: font(18),
        onBackPressed: () => Get.back(),
        actions: [],
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding / 2,
        child: CupertinoScrollbar(
           controller: _scrollController,
            radius: Radius.circular(30),
            thickness: 5,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: Dimensions.kDefaultPadding / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.kDefaultgapTop,
                  
                  /// MAIN TITLE
                  Text(AppStrings.privacyMainDes, style: Styles.bodyMedium1),
                  const Gap(20),
                  
                  /// TITLE NO 1
                  Text(AppStrings.privacyTitle1, style: Styles.bodyMediumSemiBold),
                  const Gap(20),
                  
                  /// TITLE NO 1A
                  Text(AppStrings.privacyTitle1A, style: Styles.bodyMediumSemiBold),
                  Text(AppStrings.privacyTitle1ADes, style: Styles.bodyMedium1),
                  const Gap(20),
                  
                  /// TITLE NO 1B
                  Text(AppStrings.privacyTitle1B, style: Styles.bodyMediumSemiBold),
                  Text(AppStrings.privacyTitle1BDes, style: Styles.bodyMedium1),
                  const Gap(20),
                  
                  /// LOCATION
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitleLocation, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitleLocationDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                  const Gap(20),
        
                  /// CAMERA
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitleCamera, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitleCameraDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                  const Gap(20),
        
                  /// MICROPHONE
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitleMicrophone, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitleMicrophoneDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                  const Gap(20),
        
                  /// CONTACTS
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitleContact, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitleContactDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                  const Gap(20),
        
                  /// STORAGE
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitleStorage, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitleStorageDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                  const Gap(20),
        
                  /// TITLE NO 2
                  Text(AppStrings.privacyTitle2, style: Styles.bodyMediumSemiBold),
                  const Gap(20),
                  Text(AppStrings.privacyTitle2Des, style: Styles.bodyMedium1),
                  Text(AppStrings.privacyTitle2DesList1, style: Styles.bodyMedium1),
                  const Gap(10),
                  Text(AppStrings.privacyTitle2DesList2, style: Styles.bodyMedium1),
                  const Gap(10),
                  Text(AppStrings.privacyTitle2DesList3, style: Styles.bodyMedium1),
                  const Gap(10),
                  Text(AppStrings.privacyTitle2DesList4, style: Styles.bodyMedium1),
                  const Gap(10),
                  Text(AppStrings.privacyTitle2DesList5, style: Styles.bodyMedium1),
                  const Gap(10),
                  Text(AppStrings.privacyTitle2DesList6, style: Styles.bodyMedium1),
                  const Gap(20),
        
                  /// TITLE NO 3  
                  Text(AppStrings.privacyTitle3, style: Styles.bodyMediumSemiBold),
                  const Gap(20),
        
                  /// TITLE NO 3A
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitle3A, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitle3ADes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                 const Gap(20),
        
                 /// TITLE NO 3B
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitle3B, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitle3BDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                 const Gap(20),
        
                 /// TITLE NO 3C
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitle3C, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitle3CDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                 const Gap(20),
        
                 /// TITLE NO 3D
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyTitle3D, 
                          style: Styles.bodyMediumSemiBold,
                        ),
                        TextSpan(
                          text: AppStrings.privacyTitle3DDes, 
                          style: Styles.bodyMedium1,
                        ),
                      ]
                    )
                  ),
                 const Gap(20),
        
                 /// TITLE NO 4
                 Text(AppStrings.privacyTitle4, style: Styles.bodyMediumSemiBold),
                 Text(AppStrings.privacyTitle4Des, style: Styles.bodyMedium1),
                 const Gap(20),
                 
                 /// TITLE NO 5
                 Text(AppStrings.privacyTitle5, style: Styles.bodyMediumSemiBold),
                 Text(AppStrings.privacyTitle5Des, style: Styles.bodyMedium1),
                 const Gap(20),
                 
                 /// TITLE NO 6
                 Text(AppStrings.privacyTitle6, style: Styles.bodyMediumSemiBold),
                 Text(AppStrings.privacyTitle6Des, style: Styles.bodyMedium1),
                 const Gap(20),
                 
                 /// TITLE NO 7
                 Text(AppStrings.privacyTitle7, style: Styles.bodyMediumSemiBold),
                 Text(AppStrings.privacyTitle7Des, style: Styles.bodyMedium1),
                 const Gap(20),
        
                 /// BOTTOM COMMENT 
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.privacyBottomComment, 
                          style: Styles.bodyMedium1,
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async{
                              final Uri params = Uri(
                                  scheme: 'mailto',
                                  path: 'hello@bringin.io',
                                );
                              await launchUrl(params);
                            },
                          text: AppStrings.privacyBottomCommentEmailAddr, 
                          style: Styles.bodyMedium1.copyWith(color: AppColors.mainColor),
                        ),
                      ]
                    )
                  ),
                 const Gap(20),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
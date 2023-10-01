import 'dart:io';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/dimensions.dart';
import '../../../widgets/app_bar.dart';
import '../../res/constants/strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(title: "", onBackPressed: () => Get.back(), actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            children: [
              /// default margin top
              Dimensions.kDefaultgapTop,
      
              /// bringin logo
              Container(
                width: height(80),
                height: height(80),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImagePaths.appLogoIcon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(15),
              Text("Bringin Technologies Ltd.",style: Styles.bodyMedium),
              const Gap(40),
      
              Container(
                padding: EdgeInsets.all(height(20)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius(9)),
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: .25,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// whatsapp
                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("WhatsApp", style: Styles.bodyMedium1),
                  RichText(
                  text: TextSpan(
                    text: "+88 01756195141", style: Styles.bodyMedium1,
                    ),
                  ),
                ],
              ),
              const Gap(10),
               Align(
                alignment: Alignment.centerRight,
                 child: InkWell(
                          onTap: (){},
                          highlightColor: AppColors.mainColor.withOpacity(.3),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: height(4)),
                            child: RichText(
                            text: TextSpan(
                              text: "https://wa.me/8801756175141",
                              style: Styles.smallText1.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.mainColor,
                                ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async{
                                  var contact = "8801756175141";
                                  var androidUrl = "whatsapp://send?phone=$contact";
                                  var iosUrl = "https://wa.me/$contact}";
                                  
                                  try{
                                      if(Platform.isIOS){
                                        await launchUrl(Uri.parse(iosUrl));
                                      }
                                      else{
                                        await launchUrl(Uri.parse(androidUrl));
                                      }
                                  } on Exception{
                                    Helpers().showValidationErrorDialog(errorText: 'WhatsApp is not installed.');
                                    print("whatsapp is not installed");
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
               ),
              const Gap(40),
      
              /// email
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email", style: Styles.bodyMedium1),
                  InkWell(
                        onTap: (){},
                        highlightColor: AppColors.mainColor.withOpacity(.3),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height(4)),
                          child: RichText(
                          text: TextSpan(
                            text: "hello@bringin.io",
                            style: Styles.bodyMedium1.copyWith(color: AppColors.mainColor,
                             decoration: TextDecoration.underline
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async{
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path: 'hello@bringin.io',
                                  );
                                  await launchUrl(params);
                              },
                            ),
                          ),
                        ),
                      ),
                ],
              )
                  ],
                ),
              ),
              const Gap(25),
              Container(
                padding: EdgeInsets.all(height(15)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius(9)),
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: .25,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.aboutDes1,style: Styles.bodyMedium2),
                    const Gap(25),
                    Row(
                      children: [
                        Image.asset(AppImagePaths.aboutImage,height: height(85),fit: BoxFit.fitHeight,),
                        Container(
                          width: Dimensions.screenWidth * .6,
                          child: Text(AppStrings.aboutDes2,style: Styles.bodyMedium2)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

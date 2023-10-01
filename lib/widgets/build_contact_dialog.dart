import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../Screens/recruiter_section/recruiter_main_profile/components/dialog_tile.dart';
import '../utils/services/helpers.dart';

Future<dynamic> buildContactDialog(BuildContext context) {
  return showGeneralDialog(
    transitionDuration: Duration(milliseconds: 300),
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Text('PAGE BUILDER');
    },
    barrierColor: AppColors.blackColor.withOpacity(0.70),
    barrierDismissible: false,
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  /// WHATSAPP
                  InkWell(
                    onTap: () async{
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
                        print("Whatsapp is not installed");
                      }
                      Get.back();
                    },
                    child: DialogTile(leading: "WhatsApp", trailing: "+88 01756175141")),
                  const Gap(5),

                  /// CALL
                  InkWell(
                    onTap: () async{
                      final Uri params = Uri(
                          scheme: 'tel',
                          path: '+88 01756195141',
                      );
                      await launchUrl(params);
                      Get.back();
                    },
                    child: DialogTile(leading: "Call", trailing: "+88 01756175141")),
                  const Gap(5),
                  
                  /// EMAIL
                  InkWell(
                    onTap: () async{
                      final Uri params = Uri(
                          scheme: 'mailto',
                          path: 'hello@bringin.io',
                      );
                      await launchUrl(params);
                      Get.back();
                    },
                    child: DialogTile(leading: "Email", trailing: "hello@bringin.io")),
                  
                  /// DIALOG DISMISS BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(radius(50)),
                        child: Container(
                          width: height(50),
                          height: height(50),
                          padding: EdgeInsets.all(height(2)),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                              width: height(45),
                              height: height(45),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: AppColors.whiteColor,
                                size: height(24),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

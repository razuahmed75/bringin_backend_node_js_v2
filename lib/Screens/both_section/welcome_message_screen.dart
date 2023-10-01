import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../res/dimensions.dart';
import '../../../widgets/app_bar.dart';
import '../../Hive/hive.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/strings.dart';
import '../../utils/services/keys.dart';

class WelComeMessageScreen extends StatefulWidget {
  const WelComeMessageScreen({super.key});

  @override
  State<WelComeMessageScreen> createState() => _WelComeMessageScreenState();
}

class _WelComeMessageScreenState extends State<WelComeMessageScreen> {
  int value = 0;

  Widget build(BuildContext context) {
    String welcomeMsgDes = HiveHelp.read(Keys.isRecruiter)
        ? "Choose a message to send automatically to the candidate when opening the chat."
        : "Choose a message to send automatically to the recruiter when opening the chat.";
    return Scaffold(
      appBar: appBarWidget(
          title: "Welcome Message",
          onBackPressed: () => Get.back(),
          onSavedPressed: () => Get.back()),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: Dimensions.screenWidth * .7,
                child: Text(welcomeMsgDes,
                    style: Styles.subTitle, textAlign: TextAlign.center),
              ),
            ),
            const Gap(10),

            /// WELCOME MESSAGES
            Expanded(
              child: ListView.builder(
                  itemCount: AppStrings().welcomeMsgList.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          // value = index;
                          HiveHelp.write(Keys.seekergreating, index);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height(15)),
                        margin: EdgeInsets.only(bottom: height(5)),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(radius(9)),
                        ),
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor:
                                    AppColors.mainColor.withOpacity(.4),
                              ),
                              child: Radio(
                                activeColor: AppColors.mainColor,
                                value: index,
                                groupValue:
                                    HiveHelp.read(Keys.seekergreating) ?? 0,
                                onChanged: (value) {
                                  setState(() {
                                    // this.value = value!;
                                    HiveHelp.write(Keys.seekergreating, value);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                                width: Dimensions.screenWidth * .73,
                                child: Text(AppStrings().welcomeMsgList[index],
                                    style: Styles.bodyMedium1)),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

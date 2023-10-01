import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../controllers/candidate_section/my_portfolio_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/formfield_length_checker.dart';

class MyPortfolioScreen extends StatelessWidget {
  final String? portfolioId;
  const MyPortfolioScreen({super.key, this.portfolioId});

  @override
  Widget build(BuildContext context) {
    MyPortfolioController _portfolioController = Get.find();
    
    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(
            title: "Add Portfolio Link",
            onBackPressed: () => Get.back(),
            onSavedPressed: () {
              if (_portfolioController.textFieldController.text.isEmpty) {
                Helpers().showValidationErrorDialog();
              } else if (!(_portfolioController.inputText.value.startsWith("www.") ||
                  _portfolioController.inputText.value.contains("www.") ||
                  _portfolioController.inputText.value.startsWith("http://") ||
                  _portfolioController.inputText.value.startsWith("https://")
                  // &&
                  // _portfolioController.inputText.value.split(".").length - 1 >= 1 &&
                  // _portfolioController.inputText.value.length - _portfolioController.inputText.value.lastIndexOf(".") - 1 >= 2
                  )) { // check for at least 2 characters after dot
                Helpers().showValidationErrorDialog(
                  errorText: "Please enter a valid web address",
                  durationTime: 4,
                );
              } else {
                HiveHelp.read(Keys.isPortfolioDeleteOption) == true ?
                _portfolioController.updatePortfolio(
                  id: portfolioId!,
                  data: {
                    "protfoliolink": _portfolioController.textFieldController.text.trim(),
                  }
                ) :
                _portfolioController.postPortfolio(
                  data: {
                    "protfoliolink": _portfolioController.textFieldController.text.trim(),
                  }
                );
              }
            }),
        body: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 /// E-Portfolio DES
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(30)),
                  child: Text(
                    "Enter the URL of your personal website, LinkedIn profile etc.",
                    textAlign: TextAlign.center,
                    style: Styles.bodyMedium2
                  ),
                ),
                const Gap(8),
        
                /// textfield
                Container(
                   height: height(40),
              padding: EdgeInsets.symmetric(horizontal: width(14)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius(6)),
                border: Border.all(
                  color: AppColors.appBorder,
                  width: .5,
                ),
              ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          autofocus: HiveHelp.read(Keys.isPortfolioDeleteOption) == true ? false:true,
                          inputTextWeight: FontWeight.w400,
                          controller: _portfolioController.textFieldController,
                          maxLen: 250,
                          onChanged: (value) {
                            _portfolioController.characterLen.value = value.length;
                            _portfolioController.inputText.value = value;
                          },
                          hinText: "www.example.com",
                        ),
                      ),
                      GetBuilder<MyPortfolioController>(builder: (_) {
                        // var lastDotIndex = _portfolioController.inputText.value.lastIndexOf(".");
                        bool validateInput = _portfolioController.inputText.startsWith("www.") ||
                        _portfolioController.inputText.value.contains("www.") ||
                        _portfolioController.inputText.startsWith("http://") ||
                        _portfolioController.inputText.startsWith("https://");
                        // &&
                        // _portfolioController.inputText.value.split(".").length - 1 >= 1 &&
                        // _portfolioController.inputText.value.length - lastDotIndex - 1 >= 2;
                        return _portfolioController.textFieldController.text.isEmpty
                            ? SizedBox.shrink()
                            : validateInput ? 
                      SvgPicture.asset(AppImagePaths.validated,height: height(14),width: height(14),) 
                        : IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  _portfolioController.textFieldController.clear();
                                  _portfolioController.characterLen.value = 0;
                                },
                                icon: SvgPicture.asset(AppImagePaths.close_icon),
                              );
                      }),
                    ],
                  ),
                ),
        
                /// length counter
                Obx(() => FormFieldLengthChecker(
                      characterLength: _portfolioController.characterLen.value,
                      maxLength: 250,
                    )),
                const Gap(50),
                Obx(() => _portfolioController.islodder.value == true ? SizedBox(
                  child: Center(child: Helpers.appLoader2()),
                ):SizedBox()),
              ],
            ),
          ),
        bottomNavigationBar: HiveHelp.read(Keys.isPortfolioDeleteOption) == true ? Obx(()=> BottomNavWidget(
              text: MyPortfolioController.to.isDeleting.value ? "Deleting..." : "Delete portfolio",
              onTap: MyPortfolioController.to.isDeleting.value  ? null : (){
                MyPortfolioController.to.deleteSinglePortfolio(id: portfolioId);
              },
            ),
        ) : Container(
          height: 0,
          width: 0,
        ),
      ),
    );
  }
}
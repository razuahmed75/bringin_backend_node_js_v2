import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/recruiter_section/company_registration_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';

class CompanySizeScreen extends StatelessWidget {
  const CompanySizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyRegistrationController companyRegistrationController =
        Get.find<CompanyRegistrationController>();
    return Scaffold(
      appBar: appBarWidget(
        title: "Company Size",
        onBackPressed: () => Get.back(),
        actions: [],
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "What is the total employee size in your company?",
                  textAlign: TextAlign.center,
                  style: Styles.subTitle,
                ),
              ),
              const Gap(25),
        
              // employee tile
              Obx(
                () => companyRegistrationController.isLoddingEmployee.value ==
                        true
                    ? Helpers.appLoader()
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width(15),
                          vertical: height(10),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.r),
                          border: Border.all(
                              color: Color(0xFF828282).withOpacity(0.2)),
                        ),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: companyRegistrationController
                                .employeeList.length,
                            itemBuilder: (_, index) {
                              return Obx(
                                () => RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  activeColor: AppColors.mainColor,
                                  value: index,
                                  groupValue: companyRegistrationController
                                      .selectedEmployeeGroupValue.value,
                                  onChanged: (value) {
                                    companyRegistrationController
                                        .selectedEmployeeGroupValue
                                        .value = value!;
                                    companyRegistrationController
                                            .companyEmployeesSize.value =
                                        companyRegistrationController
                                            .employeeList[index].size!;
                                    companyRegistrationController
                                            .companyEmployeeSizeId.value =
                                        companyRegistrationController
                                            .employeeList[index].sId!;
                                    Get.back();
                                  },
                                  title: Text(
                                    "${companyRegistrationController.employeeList[index].size} Employees",
                                    style: Styles.bodyMedium1,
                                  ),
                                ),
                              );
                            }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

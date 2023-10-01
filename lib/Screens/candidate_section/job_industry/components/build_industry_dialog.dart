// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/widgets/popular_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../controllers/both_category/job_industry_controller.dart';
import '../../../../models/both_category/job_industry_model.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/helpers.dart';

class Industryclass {
  int industrycount(JobIndustryController jobcontroller, Industry data) {
    var total = data.category!
        .where((element) => jobcontroller.selectedlist.contains(element.sId))
        .toList()
        .length;

    return total;
  }

  Future<dynamic> buildIndustryDialog(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius(20))),
      ),
      builder: (context) =>
          GetBuilder<JobIndustryController>(builder: (jobcontroller) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.15,
          maxChildSize: 0.90,
          expand: false,
          snap: true,
          builder: (_, ScrollController) => Padding(
            padding: EdgeInsets.only(top: height(10)),
            child: Container(
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  Container(
                    width: width(40),
                    height: height(4),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(radius(20)),
                    ),
                  ),
                  Expanded(
                    child: ExpandedTileList.builder(
                      scrollController: ScrollController,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      itemCount: jobcontroller.allIndustryList.length,
                      itemBuilder: (context, index, controller) {
                        var data = jobcontroller.allIndustryList[index];

                        return ExpandedTile(
                          theme: ExpandedTileThemeData(
                            contentBackgroundColor: AppColors.whiteColor,
                            headerColor: AppColors.whiteColor,
                          ),
                          title: Row(
                            children: [
                              Text(
                                data.industryname!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Spacer(),
                              Obx(
                                () => industrycount(jobcontroller, data) != 0
                                    ? Container(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          industrycount(jobcontroller, data)
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            shape: BoxShape.circle),
                                      )
                                    : SizedBox(),
                              )
                            ],
                          ),
                          content: Wrap(
                            spacing: 8,
                            children: List.generate(
                                jobcontroller.allIndustryList[index].category!
                                    .length, (i) {
                              var data2 = jobcontroller
                                  .allIndustryList[index].category![i];
                              jobcontroller.categorySelectionCount(jobcontroller
                                  .allIndustryList[index].category!);
                              var list = jobcontroller.selectedlist.value;
                              return InkWell(
                                onTap: () {
                                  if (!list.contains(data2.sId)) {
                                    if (list.length < 3) {
                                      list.add(data2.sId!);
                                      print(list);
                                    } else {
                                      list.remove(data2.sId);
                                      print(list);
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg:
                                              "You can select up to 3 industries");
                                    }
                                  } else {
                                    list.remove(data2.sId);
                                  }
                                  jobcontroller.selectedlist.refresh();
                                  print(list);
                                },
                                child: Obx(
                                  () => PopularTile(
                                    text: data2.categoryname!,
                                    borderColor: jobcontroller
                                            .selectedlist.value
                                            .contains(data2.sId)
                                        ? AppColors.mainColor.withOpacity(.5)
                                        : AppColors.borderColor.withOpacity(.5),
                                    textColor: jobcontroller.selectedlist.value
                                            .contains(data2.sId)
                                        ? AppColors.mainColor
                                        : AppColors.blackOpacity70,
                                  ),
                                ),
                              );
                            }),
                          ),
                          controller: controller,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

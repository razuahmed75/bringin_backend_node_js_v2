// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../controllers/both_category/job_industry_controller.dart';
import '../../../../res/color.dart';
import '../../../../widgets/popular_tile.dart';

class MostPopularSection extends StatefulWidget {
  const MostPopularSection({super.key});

  @override
  State<MostPopularSection> createState() => _MostPopularSectionState();
}

class _MostPopularSectionState extends State<MostPopularSection> {
  @override
  Widget build(BuildContext context) {
    JobIndustryController jobIndustryController = Get.find();
    return Padding(
      padding: EdgeInsets.only(top: height(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => jobIndustryController.isLoading.value
                ? Helpers.appLoader()
                : jobIndustryController.popularJobIndustryList.isEmpty ?
                 Center(
                  child: Text("Not Found"),
                 ) :
                  Wrap(
                    spacing: 12,
                    children: List.generate(
                        jobIndustryController.popularJobIndustryList.length > 20 ? 20:jobIndustryController.popularJobIndustryList.length,
                        (index) {
                          var clampedIndex = index.clamp(0, jobIndustryController.popularJobIndustryList.length);
                          var data = jobIndustryController.popularJobIndustryList.value[clampedIndex];
                          var list = jobIndustryController.selectedlist.value;
                      return GestureDetector(
                        onTap: () {
                          if(!list.contains(data.sId)){
                            if(list.length < 3){
                              list.add(data.sId!);
                              print(list);
                            }
                            else{
                              list.remove(data.sId);
                              print(list);
                              Helpers().showToastMessage(
                                gravity: ToastGravity.CENTER,
                                msg: "You can select up to 3 industries");
                            }
                          }
                          else{
                            list.remove(data.sId);
                          }
                          jobIndustryController.selectedlist.refresh();
                          print(list);
                          
                        },
                        child: PopularTile(
                          text: data.categoryname!,
                          borderColor: jobIndustryController.selectedlist.value
                                      .contains(jobIndustryController
                                          .popularJobIndustryList
                                          .value[index]
                                          .sId) ==
                                  true
                              ? AppColors.mainColor.withOpacity(.6)
                              : Color(0xFF828282).withOpacity(0.4),
                          textColor: jobIndustryController.selectedlist.value
                                      .contains(jobIndustryController
                                          .popularJobIndustryList
                                          .value[index]
                                          .sId) ==
                                  true
                              ? AppColors.mainColor
                              : AppColors.blackOpacity70,
                        ),
                      );
                    }),
                  ),
          ),
        ],
      ),
    );
  }
}

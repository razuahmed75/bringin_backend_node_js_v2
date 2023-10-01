// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/widgets/popular_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import '../../../../controllers/both_category/job_industry_controller.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';

class Industry {
  // JobIndustryController jobIndustryController = Get.find();

  // String selectcount( JobIndustryCustom data, JobIndustryController jobcontroller) {
  //   List<int> idlist = [];
  //   idlist.clear();

  //   for (var i = 0; i < jobcontroller.selectedlist.length; i++) {
  //     if (data.industrylist.any((element) => element.id == jobcontroller.selectedlist[i])) {
  //       idlist.add(jobcontroller.selectedlist[i]);
  //     }
  //   }

  //   return "${idlist.length}";
  // }

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
              //   Expanded(
              //       child: ExpandedTileList.builder(
              //     scrollController: ScrollController,
              //     padding: EdgeInsets.symmetric(horizontal: 5),
              //     itemCount: jobcontroller.jobindustrycustom.length,
              //     itemBuilder: (context, index, controller) {
              //       var data = jobcontroller.jobindustrycustom[index];
              //       return ExpandedTile(
              //         title: Row(
              //           children: [
              //             Text(data.jobindustryname),
              //             Spacer(),
              //             if (selectcount(data, jobcontroller) != "0")
              //               Container(
              //                 padding: EdgeInsets.all(5),
              //                 child: Text(
              //                   selectcount(data, jobcontroller),
              //                   style: TextStyle(color: Colors.white),
              //                 ),
              //                 decoration: BoxDecoration(
              //                     color: AppColors.mainColor,
              //                     shape: BoxShape.circle),
              //               )
              //           ],
              //         ),
              //         content: Wrap(
              //           children:
              //               List.generate(data.industrylist.length, (index2) {
              //             var data2 = data.industrylist[index2];
              //             return InkWell(
              //               onTap: () {
              //                 jobcontroller.addindustry(data2.id!);
              //               },
              //               child: PopularTile(
              //                 text: data2.name!,
              //                 borderColor: jobcontroller.selectedlist.value.contains(data2.id) == true
              //                     ? AppColors.mainColor.withOpacity(.1)
              //                     : AppColors.tileColor,
              //                 textColor: jobcontroller.selectedlist.value.contains(data2.id) == true
              //                     ? AppColors.mainColor
              //                     : AppColors.blackOpacity70,
              //               ),
              //             );
              //           }),
              //         ),
              //         controller: controller,
              //       );
              //     },
              //   ),
              // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

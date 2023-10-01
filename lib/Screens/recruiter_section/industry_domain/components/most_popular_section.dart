// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/controllers/candidate_section/industry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';
import '../../../../widgets/popular_tile.dart';

class MostPopularSection extends StatefulWidget {
  const MostPopularSection({super.key});

  @override
  State<MostPopularSection> createState() => _MostPopularSectionState();
}

class _MostPopularSectionState extends State<MostPopularSection> {
  IndustryControler industryControler = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height(20)),
      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => industryControler.isLoading.value
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        )
                                      : industryControler.popularJobIndustryList.isEmpty ?
                                      Center(
                                        child: Text("Not Found"),
                                      ) :
                                        Wrap(
                                          spacing: 8,
                                          children: List.generate(
                                              industryControler.popularJobIndustryList.value.length,
                                              (index) {
                                                var data = industryControler.popularJobIndustryList.value[index];
                                            return InkWell(
                                              onTap: () {
                                                industryControler.jobIndustryName.value = data.categoryname!;
                                                industryControler.categoryId.value = data.sId!;
                                                print(data.sId);
                                                Get.back();
                                                
                                                },
                                              child: PopularTile(
                                                text: data.categoryname!,
                                                borderColor: industryControler.categoryId == data.sId
                                                    ? AppColors.mainColor.withOpacity(.1)
                                                    : Color(0xFF828282).withOpacity(0.4),
                                                textColor:industryControler.categoryId == data.sId
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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../res/color.dart';
import '../res/dimensions.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   return ListView.builder(
    itemCount: 7,
    itemBuilder: (_,index){
      return Container(
        margin: EdgeInsets.only(bottom: height(30)), 
        child: Shimmer.fromColors(
        baseColor: AppColors.shimmerColor, 
        highlightColor: AppColors.greyColor,
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const Gap(9),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const Gap(9),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const Gap(9),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    flex: 11,
                    child: Container(
                      height: height(20),
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const Gap(11),
              Container(
                height: 1,
                width: double.maxFinite,
                color: AppColors.whiteColor,
              ),
              const Gap(9),
              Container(
                height: height(20),
                width: double.maxFinite,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
          ),
      );
    });
  }
}
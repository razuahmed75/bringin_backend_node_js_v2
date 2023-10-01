import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_switch.dart';
import '../../controllers/candidate_section/job_hunting_status_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bar.dart';

class JobHuntingStatusScreen extends StatelessWidget {
  const JobHuntingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobHuntingStatusController _controller = Get.find();
    return Scaffold(
      appBar: appBarWidget(
          title: "Job Hunting Status", 
          onBackPressed: () => Get.back(), 
          onSavedPressed: () {
            _controller.switchVal.value ?
             _controller.postJosStatus(fields: {
              "job_right_now" : _controller.switchVal.value,
            })
            :_controller.postJosStatus(fields: {
              "job_hunting" : _controller.statusTextList[_controller.statusSelectedIndex.value],
              "more_status" : _controller.jobMoreStatusList[_controller.moreStatusSelectedIndex.value],
              "job_right_now" : _controller.switchVal.value,
            })
          ;
          }
        ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.kDefaultgapTop,

                  /// job status
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      childAspectRatio: 3/2,
                    ), 
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _controller.statusTextList.length,
                    itemBuilder: (_,index){
                      return StatusTile(_controller, index);
                    }
                  ),
                  const Gap(20),

                  /// more job status
                  Container(
                    height: height(42),
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: width(20)),
                    decoration: BoxDecoration(
                      color: Color(0xFFC7C6FE),
                      borderRadius: BorderRadius.circular(radius(6)),
                      border: Border.all(color: Color(0xff336BA4).withOpacity(.3),width: .4),
                    ),
                    child: Text("More Status",style: Styles.bodyLarge),
                  ),
                  const Gap(20),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _controller.jobMoreStatusList.length,
                      itemBuilder: (_, index) {
                        return MoreStatusTile(_controller, index);
                      }),
                  const Gap(10),

                  /// Im not searching any jobs now
                  InkWell(
                    onTap: (){
                      _controller.switchVal.value = !_controller.switchVal.value;
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: width(15),vertical: height(4)),
                      decoration: Dimensions.kDecoration,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("I’m not looking for any job right now",
                                style: Styles.bodySmall1),
                          ),
                          const Gap(30),
                          Obx(()=> AppSwitch(
                            value: _controller.switchVal.value,
                            onChanged: (bool? val){
                              _controller.switchVal.value = val!;
                            },
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Obx((){
                if(_controller.isLoading.value){
                  return Padding(
                    padding: EdgeInsets.only(bottom: height(60)),
                    child: Helpers.appLoader2()
                  );
                }
                return SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget MoreStatusTile(JobHuntingStatusController _controller, int index) {
    return Container(
                margin: EdgeInsets.only(bottom: height(10)),
                child:Obx(()=> InkWell(
                    onTap:_controller.switchVal.value ? null :  (){
                      _controller.moreStatusSelectedIndex.value = index;
                    },
                    child: Container(
                        width: double.infinity,
                        height: height(40),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: width(10)),
                        decoration: BoxDecoration(
                          color: _controller.moreStatusSelectedIndex.value == index 
                            ? AppColors.mainColor.withOpacity(.25)
                            : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(radius(6)),
                          border: Border.all(
                            color: _controller.moreStatusSelectedIndex.value == index 
                              ? Colors.transparent 
                              : AppColors.borderColor,width: .2),
                        ),
                        child: Text(
                          _controller.jobMoreStatusList[index],
                          style: Styles.bodyMedium1.copyWith(
                            color: _controller.switchVal.value ? AppColors.hintColor:AppColors.blackColor
                          ),
                        ),
                      ),
                    // ),
                  ),
                ),
              );
  }

  Widget StatusTile(JobHuntingStatusController _controller, int index) {
    return Obx(()=> InkWell(
                        onTap: _controller.switchVal.value ? null : () {
                              _controller.statusSelectedIndex.value = index;
                            },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(15),vertical: height(20)),
                            decoration: BoxDecoration(
                              color: _controller.statusSelectedIndex.value == index 
                              ? AppColors.mainColor.withOpacity(.25) 
                              : Colors.transparent,
                              border: Border.all(
                                color: _controller.statusSelectedIndex.value == index 
                                ? Colors.transparent 
                                : AppColors.mainColor,
                              ),
                              borderRadius: BorderRadius.circular(radius(6)),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  _controller.statusEmojiList[index],
                                  height: height(36),
                                  width: height(36),
                                ),
                                const Gap(15),
                                Text(_controller.statusTextList[index],style: Styles.bodyMedium1.copyWith(
                                  color: _controller.switchVal.value? AppColors.hintColor:AppColors.blackColor,
                                )),
                              ],
                            ),
                          ),
                        // ),
                      ),
    );
  }
}

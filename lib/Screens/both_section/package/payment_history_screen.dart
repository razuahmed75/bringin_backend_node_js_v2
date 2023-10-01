import 'package:bringin/controllers/Package_Controller/package_controller.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/routes/screen_lists.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/ChatController/chatcontroll.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import 'components/package_tile.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(builder: (context) {
          tabController = DefaultTabController.of(context)
            ..addListener(() => setState(() {}));
          return Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size(double.maxFinite, height(40)),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Text(
                        "Payment History",
                        style: Styles.smallTitle.copyWith(
                            fontSize:
                                tabController!.index == 0 ? font(20) : font(17),
                            fontWeight: tabController!.index == 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: tabController!.index == 0
                                ? AppColors.blackColor
                                : AppColors.blackOpacity70),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "My Package",
                        style: Styles.smallTitle.copyWith(
                            fontSize:
                                tabController!.index == 1 ? font(20) : font(17),
                            fontWeight: tabController!.index == 1
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: tabController!.index == 1
                                ? AppColors.blackColor
                                : AppColors.blackOpacity70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(children: [
              PaymentHistory(),
              MyPackage(),
            ]),
          );
        }));
  }
}

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  bool isLoading = false;
  PackageController controller = Get.find<PackageController>();
  Future load() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await controller.getPaymentHitory();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Helpers.appLoader2())
        : controller.paymentHistoryList.isEmpty
            ? EmptyTile()
            : Padding(
                padding: Dimensions.kDefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                            controller.payHistoryTitlelist.length,
                            (index) => Container(
                                  width: Dimensions.screenWidth * .17,
                                  child: Text(
                                      controller.payHistoryTitlelist[index],
                                      style: Styles.bodyMedium.copyWith(
                                        color: AppColors.mainColor,
                                      )),
                                ))
                      ],
                    ),
                    Gap(height(10)),
                    Expanded(
                        child: ListView.builder(
                            itemCount: controller.paymentHistoryList.length,
                            itemBuilder: (context, index) {
                              var data = controller.paymentHistoryList[index];
                              var dateTime =
                                  data.transactionID!.date!.split(" ").first;
                              var date = dateTime.substring(2, dateTime.length);
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                      () => PaymentReceiptScreen(data: data));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height(10)),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: index == 0
                                              ? BorderSide(
                                                  color: AppColors.appBorder,
                                                  width: .5,
                                                )
                                              : BorderSide.none,
                                          bottom: index ==
                                                  (controller.paymentHistoryList
                                                          .length -
                                                      1)
                                              ? BorderSide.none
                                              : BorderSide(
                                                  color: AppColors.appBorder,
                                                  width: .5,
                                                ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          // color: Colors.amber,
                                          width: Dimensions.screenWidth * .17,
                                          child: Text(date,
                                              style: Styles.bodySmall1)),
                                      // child: Text(DateFormat('yy-MM-dd').format(DateTime.parse(data.transactionID!.date!)),style: Styles.bodySmall1)),
                                      Container(
                                          // color: Colors.amber,
                                          width: Dimensions.screenWidth * .17,
                                          child: Text(data.packageid!.name!,
                                              style: Styles.bodySmall1)),
                                      Container(
                                          // color: Colors.amber,
                                          width: Dimensions.screenWidth * .17,
                                          child: Text(
                                              data.transactionID!
                                                  .paymentProcessor!,
                                              style: Styles.bodySmall1)),
                                      Container(
                                          // color: Colors.amber,
                                          width: Dimensions.screenWidth * .17,
                                          child: Row(
                                            children: [
                                              Text(
                                                  "৳" +
                                                      data.packageid!.amount
                                                          .toString(),
                                                  style: Styles.bodySmall1),
                                              SizedBox(width: width(5)),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: height(3)),
                                                child: SvgPicture.asset(
                                                    AppImagePaths
                                                        .arrowForwardIcon),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              );
  }
}

Widget EmptyTile() {
  return Column(
    children: [
      Image.asset(
        AppImagePaths.empty_payment_history,
        height: height(92),
        width: height(92),
        fit: BoxFit.cover,
      ),
      Gap(height(15)),
      Center(
        child: RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "Your payment history is empty!\n",
              style: Styles.bodyMedium2,
            ),
            TextSpan(
              text: "Click here",
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Get.toNamed(RouteHelper.getPurchasePackageRoute()),
              style: Styles.bodyMedium.copyWith(
                color: AppColors.mainColor,
              ),
            ),
            TextSpan(
              text: " to purchase a package.",
              style: Styles.bodyMedium2,
            ),
          ],
        )),
      )
    ],
  );
}

class MyPackage extends StatefulWidget {
  const MyPackage({super.key});

  @override
  State<MyPackage> createState() => _MyPackageState();
}

class _MyPackageState extends State<MyPackage> {
  bool isLoading = false;
  ChatControll chatControll = Get.put(ChatControll());
  Future load() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(child: Helpers.appLoader2())
          : RecruiterEditMainProfileController
                  .to.recruiterProfileInfoList.isEmpty
              ? Text("Not found")
              : Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.premium == false
                        ? "" : "Your Current Active Package",
                        style: Styles.bodyMedium,
                      ),
                      Gap(RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.premium == true ? 0:height(61)),
                      RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.premium == false 
                      ?Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                            "assets/icon2/cancle.png",
                            height: 68.h,
                            width: 102.w,
                          )),
                          SizedBox(height: 10.h),
                          Text(
                            "You didn't purchase any package yet!",
                            textAlign: TextAlign.center,
                            style: Styles.bodyLargeMedium,
                          ),
                          ],
                        ),
                      ):SizedBox(),
                      if (RecruiterEditMainProfileController
                              .to.recruiterProfileInfoList[0].other!.premium ==
                          true)
                        PackageTile(
                          isPurchasePackage: false,
                          padding: EdgeInsets.all(height(15)),
                          packageLevel: RecruiterEditMainProfileController
                                      .to
                                      .recruiterProfileInfoList[0]
                                      .other!
                                      .package ==
                                  null
                              ? ""
                              : RecruiterEditMainProfileController
                                  .to
                                  .recruiterProfileInfoList[0]
                                  .other!
                                  .package!
                                  .packageid!
                                  .name!,
                          chatsAmount:
                              "${RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package == null ? "" : RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package!.packageid!.chat} Chats Per Day",
                          takaAmount:
                              "${RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package == null ? "" : RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package!.packageid!.amount} BDT",
                          durationMonth:
                              "${RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package == null ? "" : RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package!.packageid!.durationTime} Month",
                        ),
                      const Gap(15),
                      RecruiterEditMainProfileController.to
                                  .recruiterProfileInfoList[0].other!.package ==
                              null
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: height(12), horizontal: width(12)),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(radius(9)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(25)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                chatControll
                                                    .recruiter_today_conv.length
                                                    .toString(),
                                                style:
                                                    Styles.bodyMediumSemiBold),
                                            const Gap(3),
                                            Text("Todays Chat",
                                                style: Styles.bodyMedium1),
                                          ],
                                        ),
                                        Container(
                                          height: height(34),
                                          width: 1,
                                          color: AppColors.appBorder,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                RecruiterEditMainProfileController
                                                    .to.packageRemainingDays
                                                    .toString(),
                                                style:
                                                    Styles.bodyMediumSemiBold),
                                            const Gap(3),
                                            Text("Remaining Days",
                                                style: Styles.bodyMedium1),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Purchase Date" +
                                              " : " +
                                              "${DateFormat("dd-MM-yyyy").format(RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package!.starddate!.toLocal())}",
                                          style: Styles.bodySmall1.copyWith(
                                              color: AppColors.blackColor
                                                  .withOpacity(.9),
                                              fontWeight: FontWeight.w300)),
                                      Text(
                                          "Vaild Till" +
                                              " : " +
                                              "${DateFormat("dd-MM-yyyy").format(RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].other!.package!.enddate!.toLocal())}",
                                          style: Styles.bodySmall1.copyWith(
                                              color: AppColors.blackColor
                                                  .withOpacity(.9),
                                              fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      const Gap(25),
                      AppButton(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getPurchasePackageRoute()),
                        bgColor: Colors.transparent,
                        buttonHeight: height(36),
                        buttonWidth: double.maxFinite,
                        splashColor: AppColors.mainColor.withOpacity(.1),
                        highLightColor: AppColors.mainColor.withOpacity(.1),
                        borderColor: AppColors.mainColor,
                        text: "Upgrade Package",
                        textColor: AppColors.mainColor,
                        textSize: font(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
    );
  }
}

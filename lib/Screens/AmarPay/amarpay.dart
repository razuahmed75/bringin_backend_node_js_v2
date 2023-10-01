import 'package:aamarpay/aamarpay.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../res/dimensions.dart';
import '../../controllers/Package_Controller/package_controller.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../models/Package/packagelist.dart';

class MyPay extends StatefulWidget {
  final PackageList package;
  const MyPay({super.key, required this.package});

  @override
  State<MyPay> createState() => _MyPayState();
}

class _MyPayState extends State<MyPay> {
  bool isLoading = false;
  final recuiterprofile = Get.find<RecruiterEditMainProfileController>();
  int transitionid = DateTime.now().millisecondsSinceEpoch;
  PackageController packageController = Get.put(PackageController());
  bool isSandBox = false;
  late String signature = isSandBox
      ? "dbb74894e82415a2f7ff0ec3a97e4183"
      : "cdc5d825cb402db73c2a60b80bf0f1b7";

  late String storeID = isSandBox ? "aamarpaytest" : "bringin";

  @override
  Widget build(BuildContext context) {
    return Aamarpay(
      // This will return a payment url based on failUrl,cancelUrl,successUrl
      returnUrl: (String url) {
        // print("payment  $url");
      },
      // This will return the payment loading status
      isLoading: (bool loading) {
        setState(() {
          isLoading = loading;
        });
      },
      paymentStatus: (value) {
        // print("payment ${value}");
      },
      // This will return the payment state with a message
      status: (EventState event, String message) {
        if (event == EventState.success) {
          print("payment ${message}");
          print("payment ${transitionid}");
          packageController.packagebuy(
              packageid: widget.package.id,
              transactionID: transitionid.toString());
        }
      },
      cancelUrl: "http://www.merchantdomain.com/can",
      successUrl: "http://www.merchantdomain.com/suc",
      failUrl: "http://www.merchantdomain.com/faile",
      customerEmail: "${recuiterprofile.recruiterProfileInfoList.first.email}",
      customerMobile:
          "${recuiterprofile.recruiterProfileInfoList.first.number}",
      customerName:
          "${recuiterprofile.recruiterProfileInfoList.first.firstname} ${recuiterprofile.recruiterProfileInfoList.first.lastname}",
      signature: signature,
      storeID: storeID,
      transactionAmount: "${widget.package.amount}",
      transactionID: "${transitionid}",
      description: "production_mode",
      // When the application goes to the producation the isSandbox must be false
      isSandBox: isSandBox,
      child: isLoading
          ? Center(
              child: SpinKitThreeBounce(
                color: Colors.black,
                size: height(25),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width(8), vertical: height(3)),
              decoration: ShapeDecoration(
                color: Color(0xFF00A0DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Buy Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:bringin/Http/get.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Hive/hive.dart';
import '../../utils/services/keys.dart';

class PushNotificationController extends GetxController {
  static PushNotificationController get to => Get.find();

  String? userId;
  Future<String?> getUserId() async {
    final status = await OneSignal.User.pushSubscription;
    OneSignal.Notifications.requestPermission(true);
    print("sdhvjshdvjsd ${status.id}");
    userId = status.id;
    print("hdvbcjshdvjsd ${userId}");
    // permissioncheck();
    NotificationPermissions.requestNotificationPermissions(
            iosSettings: const NotificationSettingsIos(
                sound: true, badge: true, alert: true))
        .then((_) {
      print("hdvbcjshdvjsd${_.name}");

      // when finished, check the permission status

      // permissionStatusFuture =
      //     getCheckNotificationPermStatus();
    });
    pushNotification(fields: {
      "isrecruiter": HiveHelp.read(Keys.isRecruiter),
      "pushnotification": userId,
    });
    return userId;
  }

  Future<void> pushNotification({Map<String, dynamic>? fields}) async {
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.pushNotificationUrl, fields: fields)
        .then((response) {
      if (response.statusCode == 200) {
        print("Notification api is Called: " + response.body);
      } else {
        print(response.body);
        Helpers().showToastMessage(msg: "Something went wrong");
      }
    });
  }

  Future<bool?> permissioncheck() async {
    NotificationPermissions.requestNotificationPermissions(
            iosSettings: const NotificationSettingsIos(
                sound: true, badge: true, alert: true))
        .then((_) {
      // when finished, check the permission status

      // permissionStatusFuture =
      //     getCheckNotificationPermStatus();
    });
  }
}

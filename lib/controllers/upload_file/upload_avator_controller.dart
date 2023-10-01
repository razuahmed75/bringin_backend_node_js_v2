import 'dart:convert';
import 'dart:io';
import 'package:bringin/controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_provider;
import '../../Hive/hive.dart';
import '../../Http/get.dart';
import '../../utils/services/keys.dart';
import '../candidate_section/candidate_edit_main_profile_controller.dart';

class UploadAvatorController extends GetxController {
  Future getAvator() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      String filePath = file.path;
      String fileExtension = path_provider.extension(filePath);
      String newName = 'Userimage$fileExtension';
      File renamedFile = await file.rename('${file.parent.path}/$newName');
      File compressedFile = await FlutterNativeImage.compressImage(
          renamedFile.path,
          quality: 50,
          percentage: 50);
      final fileSizeInBytes = await renamedFile.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      if (fileSizeInMB > 2) {
        Helpers.showAlartMessage(
            msg: "File size should not exceed 2 MB",
            gravity: ToastGravity.CENTER);
      } else {
        uploadAvater(compressedFile.path);
      }
    }
  }

  Future uploadCamaraProfile() async {
    final ImagePicker _picker = ImagePicker();
    XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      File file = File(picked.path);
      String filePath = picked.path;
      print("picked path is: " + filePath.toString());
      String fileExtension = path_provider.extension(file.path);
      String newName = 'my-profile$fileExtension';

      /// replace with your desired new name
      print("new image name is :" + newName.toString());
      File renamedFile = await file.rename('${file.parent.path}/$newName');
      File compressedImage = await FlutterNativeImage.compressImage(
          renamedFile.path,
          quality: 50,
          percentage: 50);
      uploadAvater(compressedImage.path);
    }
  }
}

Future uploadAvater(String filePath) async {
  CandidateEditMainProfileController controller =
      Get.find<CandidateEditMainProfileController>();
  print("uploading your photo==================");
  Helpers().showToastMessage(msg: "Uploading your photo...");
  await Httphelp.uploadFile(
          ENDPOINT_URL: HiveHelp.read(Keys.isRecruiter)
              ? AppConstants.recruiterMainProfileUpdateUrl
              : AppConstants.candidateProfileUpdateUrl,
          imgpath: filePath)
      .then((data) {
    if (data.statusCode == 200) {
      if (HiveHelp.read(Keys.isRecruiter) == true) {
        RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
      } else {
        HiveHelp.write(Keys.isUploadeRealAvatar, true);
        CandidateEditMainProfileController.to.getProfileInfo();
      }
      print(data.body);
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
    } else {
      print("error: " + data.body);
      print("error status : " + data.statusCode.toString());
      Helpers().showToastMessage(msg: "Something went wrong");
    }
  });
}

/// UPLOAD PROFILE DAFAULT AVATAR FROM ASSET
Future<void> uploadDefaultAvater(filePath) async {
  CandidateEditMainProfileController controller =
      Get.find<CandidateEditMainProfileController>();
  print("uploading your avatar==================");
  Helpers().showToastMessage(msg: "Uploading your avatar...");
  await Httphelp.uploadAssetImg(
    ENDPOINT_URL: HiveHelp.read(Keys.isRecruiter)
        ? AppConstants.recruiterMainProfileUpdateUrl
        : AppConstants.candidateProfileUpdateUrl,
    bytes: filePath,
  ).then((data) {
    if (data.statusCode == 200) {
      if (HiveHelp.read(Keys.isRecruiter) == true) {
        RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
      } else {
        controller.getProfileInfo();
        HiveHelp.write(Keys.isUploadeRealAvatar, false);
      }
      print(data.body);
      Helpers().showToastMessage(msg: "Successfully updated");
    } else {
      Helpers().showToastMessage(msg: "Something went wrong");
    }
    print("The printed value is: " + data.body.toString());
  });
}

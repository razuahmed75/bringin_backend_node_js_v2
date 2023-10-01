// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path_provider;
import '../../Http/get.dart';
import '../../utils/services/helpers.dart';
import '../candidate_section/resume_management_controller.dart';

class UploadRecruiterDocumentController extends GetxController {
  /// UPLOAD DOCUMENT
  File? compressedImage;
  File? compressedPdf;
  String? shortenedPath;
  String? fileExtension;
  File? renamedFile;
  FilePickerResult? result;

  Future uploadDocument() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
    );
    if (result != null) {
      File file = File(result!.files.single.path.toString());
      String filePath = file.path;
      fileExtension = path_provider.extension(filePath);
      String oldName = file.path.split('/').last;
      String newName =
          'my-resume$fileExtension'; // replace with your desired new name
      renamedFile = await file.rename('${file.parent.path}/$oldName');
      final fileSizeInBytes = await renamedFile!.length();
      final fileSizeInMB = fileSizeInBytes / (1000 * 1000);
      print('PDF file size: ${fileSizeInMB.toStringAsFixed(2)} MB');

      /// COMPRESS IMAGE
      if (fileExtension != ".pdf") {
        compressedImage = await FlutterNativeImage.compressImage(
            renamedFile!.path,
            quality: 50,
            percentage: 50);
        print("Compressed image is=========" + compressedImage!.path);
        update();
      } else {
        compressedPdf = renamedFile;
        print("compress pdf path: "+ compressedPdf!.path);
        // compressPdf(renamedFile!, newName);
        update();
      }
    }
  }

  /// UPLOAD RESUME
  File? compressedResume;
  File? renamedResume;
  Future uploadResume() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path.toString());
      String filePath = file.path;
      var fileExtension = path_provider.extension(filePath);
      String oldName = file.path.split('/').last;
      String newName =
          'my-resume$fileExtension';
      renamedResume = await file.rename('${file.parent.path}/$oldName');
      final fileSizeInBytes = await renamedResume!.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      print('PDF file size: ${fileSizeInMB.toStringAsFixed(2)} MB');
      if(fileSizeInMB > 5){
        Helpers.showAlartMessage(msg: "File size should not exceed 5 MB",gravity: ToastGravity.CENTER);
      }else{
        postResume(
          renamedResume!.path,
          renamedResume,
        );
      }

      /// COMPRESS PDF
      // if (fileExtension == ".pdf") {
      //   compressPdf(renamedResume!, newName);
      //   update();
      // }
    }
  }



  /// TO RESET FILE PICKER RESULT
  resetImagePickerResult() {
    result = null;
    update();
  }

  /// POST COMPANY DOCUMENT
  var isLoading = false.obs;
  var isBack = false.obs;
  Future<void> postCompanyVerify(
      {String? imgpath,bool? isCompanyVerify = true,String? type,String? path}) async {
    print("uploading your doc========================");
    isLoading.value = true;

    var data = isCompanyVerify==true ? await Httphelp.uploadFile(
      ENDPOINT_URL: AppConstants.recruiterDocVerifyUrl,
      imgpath: imgpath
    ):
    await Httphelp().recruiter_verify_doc_upload(
      ENDPOINT_URL: AppConstants.recruiterIdentyVerifyUrl, type: type,path: path);
    if (data.statusCode ==200) {
      print(data.body);
      Helpers().showToastMessage(msg: "Submitted Successfully");
      isBack.value = true;
      result = null;
    } else {
      print(data.body);
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
      isBack.value = false;
    }
    isLoading.value = false;
    update();
  }
}

/// POST UPLOAD RESUME
var isUploadingResume = false.obs;
Future postResume(filePath, fileName) async {
  isUploadingResume.value = true;
  print("uploading your resume================");
  Helpers().showToastMessage(
    msg: "Uploading your resume...",
  );
  await Httphelp.uploadFile(
          ENDPOINT_URL: AppConstants.candidateUploadResumeUrl, fieldName: "resume",imgpath: filePath)
      .then((value) {
    if (value.statusCode == 200) {
      ResumeManagementController.to.getallresume();
        Get.back();
      Helpers().showToastMessage(
        msg: jsonDecode(value.body)['message'],
      );
      print(value.body);
      isUploadingResume.value = false;
    } else {
      isUploadingResume.value = false;
      print(value.body);
      Helpers().showToastMessage(
        msg: "Something went wrong, Request Entity Too Large!",
      );
    }
  });
}







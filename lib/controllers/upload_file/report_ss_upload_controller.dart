
import 'dart:io';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path_provider;
import '../../Hive/hive.dart';
import '../../utils/services/keys.dart';

class ReportController extends GetxController{
  static ReportController get to => Get.find();

  var textFeildController = TextEditingController().obs;
  var isRecruiter = HiveHelp.read(Keys.authToken);

  var characterLength = 0.obs;
  
  /// THESE ARE FROM CANDIDATE SECTION
  RxList<String> candidateSelectedItems = <String>[].obs;
  List<String> candidateItems = [
    "Fake Job",
    "Fake Recruiter",
    "Harassment",
    "Fraud",
    "Spam or Scam",
    "Others"
  ];
  RxList<bool> candidateChecked = [false, false, false, false, false, false].obs;
  
  /// THESE ARE FROM RECRUITER SECTION
  RxList<String> recruiterSelectedItems = <String>[].obs;
  List<String> recruiterItems = [
    "Fake Candidate",
    "Wrong Profile Information",
    "Harassment",
    "Fraud",
    "Violence",
    "Wrong Identity",
    "Spam or Scam",
    "Others"
  ];
  RxList<bool> recruiterChecked = [false, false, false, false, false, false, false, false].obs;
  
  
  
  File? compressedFile;
  String? newName;
  FilePickerResult? result;
  String? filePath;
  File? renamedFile;
  Future getScreenShot ()async{
  result = await FilePicker.platform.pickFiles( type: FileType.image);
  if(result != null){
   File file = File(result!.files.single.path.toString());
   filePath = file.path;
   String fileExtension = path_provider.extension(filePath!);
   newName = 'User image$fileExtension'; // replace with your desired new name
   renamedFile = await file.rename('${file.parent.path}/$newName');
   compressedFile = await FlutterNativeImage.compressImage(renamedFile!.path,quality: 80, percentage: 80);
   final compressedFileBytes = await compressedFile!.length();
   final compressedMB = compressedFileBytes / (1024 * 1024);
   print('Compress file size: ${compressedMB.toStringAsFixed(2)} MB');
   Helpers().showToastMessage(msg: "Screenshot has added");
   update();
  }else{
    Helpers().showToastMessage(msg: "Cancelled by user");
  }
}
  void resetPath(){
    renamedFile = null;
    update();
  }
}

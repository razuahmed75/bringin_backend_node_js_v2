
import 'package:bringin/Http/get.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:get/get.dart';
import '../../models/candidate_section/education_level_model.dart';

class EducationLevelController extends GetxController{
  static EducationLevelController get to => Get.find();
  
  List<EducationLevelModel> educationLevelList = <EducationLevelModel>[];
  RxList expansionStates = [].obs;
  var selectedDegree = "".obs;
  var selectedEducationLevel = "".obs;
  var selectedEducationLevellId = "".obs;
  var selectedDegreeId = "".obs;
  var selectedIndex = "".obs;
  var isLoading = false;
  
  Future<void> getEducationLevel() async{
    print("Getting data................");
    isLoading = true;
    await Httphelp.get(
      ENDPOINT_URL: AppConstants.educationLevelUrl).then((data) {
        educationLevelList=[];
        
        isLoading = false;
        if(data.statusCode==200){
          educationLevelList = educationLevelModelFromJson(data.body);   
        }
        else{
          educationLevelList=[];
        }
        update();
    });
  }

}


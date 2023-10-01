import 'package:bringin/Http/get.dart';
import 'package:get/get.dart';
import '../../models/candidate_section/job_filter_model.dart';
import '../../res/constants/app_constants.dart';

class JobFilterController extends GetxController{
  static JobFilterController get to => Get.find();
  
  /// WORKPLACE POLICY
  RxList<bool> selectedwpVal = <bool>[].obs;
  RxList<String> selectedwpKey = <String>["All"].obs;
  List<Workplace> workplacePolicy = [];
  List<bool> allWPolicy = [];

  /// REQUIRED EDUCATION
  RxList<String>? selectedEduVal = <String>[].obs;
  RxList<String>? selectedEduKey = <String>["All"].obs;
  List<Education> educationList = [];
  List<String> allEdu=[];

  /// OFFERED SALARY (MONTHLY)
  RxList<String> selectedSalaryVal = <String>[].obs;
  RxList<String> selectedSalaryKey = <String>["All"].obs;
  List<Salary> offeredSalaryList = [];
  List<CustomSalary> customSalary = [];
  List<String> allSalary=[];

  /// REQUIRED EXPERIENCE
  var requiredExpIndex = 0.obs;
  RxList<String>? selectedExpVal = <String>[].obs;
  RxList<String>? selectedExpKey = <String>["All"].obs;
  List<Experience> requiredExperienceList = [];
  List<String> allexp=[];

  /// INDUSTRY
  RxList<String>? selectedIndustryVal = <String>[].obs;
  RxList<String>? selectedIndustryKey = <String>["All"].obs;
  List<Industry> industryList = [];
  List<String> allIndustry=[];

  /// COMPANY STRENGTH
  RxList<String>? selectedCompanyStrVal = <String>[].obs;
  RxList<String>? selectedCompanyStrKey = <String>["All"].obs;
  List<Companysize> companyStrengthList = [];
  List<String> allcStrength=[];

 /// RESET FILTER VALUE
 void resetFilterValue() {
  /// CLEAR ALL LIST
  selectedwpVal.clear();
  selectedEduVal!.clear();
  selectedSalaryVal.clear();
  selectedExpVal!.clear();
  selectedIndustryVal!.clear();
  selectedCompanyStrVal!.clear();

  selectedwpKey.clear();
  selectedEduKey!.clear();
  selectedSalaryKey.clear();
  selectedExpKey!.clear();
  selectedIndustryKey!.clear();
  selectedCompanyStrKey!.clear();

  /// ADD DEFAULT VALUE
  selectedwpVal.addAll(allWPolicy);
  selectedEduVal!.addAll(allEdu);
  selectedSalaryVal.addAll(allSalary);
  selectedExpVal!.addAll(allexp);
  selectedIndustryVal!.addAll(allIndustry);
  selectedCompanyStrVal!.addAll(allcStrength);

  selectedwpKey.add("All");
  selectedEduKey!.add("All");
  selectedSalaryKey.add("All");
  selectedExpKey!.add("All");
  selectedExpKey!.add("All");
  selectedCompanyStrKey!.add("All");
 }

  var isLoading = false.obs;
  Future<void> getJobFilter() async{
    isLoading.value = true;
    Httphelp.get(
      ENDPOINT_URL: AppConstants.getjobFilterUrl).then((value){
        if(value.statusCode==200){

          workplacePolicy.clear();
          educationList.clear();
          offeredSalaryList.clear();
          customSalary.clear();
          requiredExperienceList.clear();
          industryList.clear();
          companyStrengthList.clear();
          allWPolicy.clear();

          workplacePolicy.add(Workplace(name: "All",value: null));
          educationList.add(Education(name: "All",id: jobFilterModelFromJson(value.body).alleducation!.join(',')));
          customSalary.add(CustomSalary(id: jobFilterModelFromJson(value.body).allsalary!.join(','),salary: "All"));
          requiredExperienceList.add(Experience(id: jobFilterModelFromJson(value.body).allexperience!.join(','), name: "All"));
          industryList.add(Industry(id: jobFilterModelFromJson(value.body).allindustry!.join(','),industryname: "All"));
          companyStrengthList.add(Companysize(id: jobFilterModelFromJson(value.body).allcompanysize!.join(','),size: "All",v: 0,));

          allWPolicy.addAll(jobFilterModelFromJson(value.body).allworkplace!);
          allEdu.addAll(jobFilterModelFromJson(value.body).alleducation!);
          allSalary.addAll(jobFilterModelFromJson(value.body).allsalary!);
          allexp.addAll(jobFilterModelFromJson(value.body).allexperience!);
          allIndustry.addAll(jobFilterModelFromJson(value.body).allindustry!);
          allcStrength.addAll(jobFilterModelFromJson(value.body).allcompanysize!);

          workplacePolicy.addAll(jobFilterModelFromJson(value.body).workplace!);
          educationList.addAll(jobFilterModelFromJson(value.body).education!);
          offeredSalaryList.addAll(jobFilterModelFromJson(value.body).salary!);
          requiredExperienceList.addAll(jobFilterModelFromJson(value.body).experience!);
          industryList.addAll(jobFilterModelFromJson(value.body).industry!);
          companyStrengthList.addAll(jobFilterModelFromJson(value.body).companysize!);

          for(var i in jobFilterModelFromJson(value.body).salary!){
            customSalary.add(CustomSalary(id: i.id,salary: i.minSalary! +" "+ i.maxSalary! +" "+ i.currency!));
          }

          isLoading.value = false;
        }
        else{
          isLoading.value = false;
          workplacePolicy=[];
          educationList=[];
          offeredSalaryList=[];
          customSalary=[];
          requiredExperienceList=[];
          industryList=[];
          companyStrengthList=[];
        }
      });
  }

}
class CustomSalary{
  String? id;
  String? salary;

  CustomSalary({this.id, this.salary});
}


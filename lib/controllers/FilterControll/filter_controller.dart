import 'package:get/get.dart';

import '../../models/Filter/filter.dart';

class FilterControll extends GetxController {
  var workplacedata = <bool>[].obs;
  var education = <String>[];
  var salary =<Allsalary>[];
  var experience = <String>[];
  var industry = <String>[];
  var companysize = <String>[];

  void workplaceadd(List<bool> _workplacedata) {
    workplacedata.addAll(_workplacedata);
  
  }

  void addeducation(List<String> education_) {
    education.addAll(education_);
 
  }

  void addsalary(List<Allsalary> salary_) {
    salary.addAll(salary_);

  }

  void addexperience(List<String> experience_) {
    experience.addAll(experience_);

  }

  void addindustry(List<String> industry_) {
    industry.addAll(industry_);

  }

  void addcompanysize(List<String> companysize_) {
    companysize.addAll(companysize_);

  }
}

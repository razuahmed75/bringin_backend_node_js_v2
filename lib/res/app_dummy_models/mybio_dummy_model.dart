import '../constants/strings.dart';

class MyBioEx {
  final String avatar;
  final String proficiency;
  final String description;

  MyBioEx({
    required this.avatar,
    required this.proficiency,
    required this.description,
  });
}

List<MyBioEx> aboutMeList = <MyBioEx>[
  MyBioEx(
      avatar: AppStrings.myBioExAva1,
      proficiency: AppStrings.aboutMeExProf1,
      description: AppStrings.aboutMeExDes1),
  MyBioEx(
      avatar: AppStrings.myBioExAva2,
      proficiency: AppStrings.aboutMeExProf2,
      description: AppStrings.aboutMeExDes2),
  MyBioEx(
      avatar: AppStrings.myBioExAva3,
      proficiency: AppStrings.aboutMeExProf3,
      description: AppStrings.aboutMexDes3),
  MyBioEx(
      avatar: AppStrings.myBioExAva4,
      proficiency: AppStrings.aboutMeExProf4,
      description: AppStrings.aboutMeExDes4),
  MyBioEx(
      avatar: AppStrings.myBioExAva5,
      proficiency: AppStrings.aboutMeExProf5,
      description: AppStrings.aboutMeExDes5),
];

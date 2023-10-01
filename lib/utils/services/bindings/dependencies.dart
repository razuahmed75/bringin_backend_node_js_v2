import 'package:get/get.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import 'bindings_controllers_list.dart';

class InitDependencies implements Bindings {
  @override
  void dependencies() {
    /// CANDIDATE SECTION
    Get.lazyPut(() => MyPortfolioController(),fenix: true);
    Get.lazyPut(() => JobHuntingStatusController(),fenix: true);
    Get.lazyPut(() => ExpertiseAreaController(),fenix: true);
    Get.lazyPut(() => StudyDurationController(),fenix: true);
    Get.lazyPut(() => AboutMeController(),fenix: true);
    Get.put(CandidateCareerPrefController(),permanent: true);
    Get.lazyPut(() => CandidateMainProfileController(),fenix: true);
    Get.lazyPut(() => SelectLocationController(),fenix: true);
    Get.lazyPut(() => EducationLevelController(),fenix: true);
    Get.lazyPut(() => MyResumeController(),fenix: true);
    Get.lazyPut(() => WorkExperienceController(),fenix: true);
    Get.lazyPut(() => MyDesignationController(),fenix: true);
    Get.lazyPut(() => DepartmentController(),fenix: true);
    Get.lazyPut(() => DutiesAndResponsibilitiesController(),fenix: true);
    Get.lazyPut(() => CareerMileStoneController(),fenix: true);
    Get.lazyPut(() => EducationController(),fenix: true);
    Get.lazyPut(() => OtherActivitiesController(),fenix: true);
    Get.lazyPut(() => MySkillsController(),fenix: true);
    Get.put(JobControll(),permanent: true);
    Get.put(CandidateEditMainProfileController(),permanent: true);
    Get.lazyPut(() => IndustryControler(),fenix: true);
    Get.lazyPut(() => CandidateFNameController(),fenix: true);
    Get.lazyPut(() => CandidateLNameController(),fenix: true);
    Get.lazyPut(() => CandidateEmailEditController(),fenix: true);
    Get.lazyPut(() => CandidatePhoneEditController(),fenix: true);
    Get.lazyPut(() => UploadAvatorController(),fenix: true);
    Get.lazyPut(() => UploadRecruiterDocumentController(),fenix: true);
    Get.lazyPut(() => JobFilterController(),fenix: true);
    Get.lazyPut(() => ReportController(),fenix: true);
    Get.lazyPut(() => ResumeManagementController(),fenix: true);


    Get.lazyPut(() => SettingsController(),fenix: true);
    Get.lazyPut(() => PushNotificationController(),fenix: true);
    

    /// RECRUITER-SECTION
    Get.put(RecruiterEditMainProfileController(),permanent: true);
    Get.put(RecruiterJobPostController(),permanent: true);
    Get.lazyPut(() => CompanyRegistrationController(),fenix: true);
    Get.lazyPut(() => RecruiterIdentyVerifyController(),fenix: true);
    Get.lazyPut(() => JobPostPreviewController(),fenix: true);
    Get.lazyPut(() => CandidateControll(),fenix: true);

    

    /// BOTH-SECTION
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => BottomNavController(),fenix: true);
    Get.lazyPut(() => SignInController(),fenix: true);
    Get.lazyPut(() => OtpController(),fenix: true);
    Get.lazyPut(() => JobIndustryController(),fenix: true);
    Get.lazyPut(() => ExpertiseAreaController(),fenix: true);
    Get.lazyPut(() => PackageController(),fenix: true);
  }
}

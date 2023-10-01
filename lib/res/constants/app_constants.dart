class AppConstants {
  /// API BASE URL
  // static const String baseUrl = "https://app.bringin.io";
  static const String baseUrl = "https://rsapp.bringin.io";
  // static const String baseUrl = "http://localhost:3002";
  static const String socket = "https://chat.bringin.io";
  // static const String socket = "http://localhost:3002";

  /// BASE IMAGE URL TO GET AN IMAGE FROM SERVER
  static const String imgurl = "$baseUrl/";
 
  /// BOTH-CATEGORY
  static const String signInUrl = "/singup";
  static const String otpUrl = "/verify";
  static const String allJobIndustryUrl = "/job_industrylist";
  static const String functionalAreaUrl = "/job_functionalarea";
  static const String skillUrl = "/seeker_skill";
  static const String defaultSkillUrl = "/default_skill";
  static const String switchAccountUrl = "/switch";
  static const String notificationUrl = "/notification";
  static const String pushNotificationUrl = "/push_notification";
  static const String packageListUrl = "/package";
  static const String cancelSubscriptionUrl = "/subscription_cancle";
  static const String userPaymentHistoryUrl = "/user_payment_history";
  static const String totalChatHistoryUrl = "/chat_history";
  static const String deleteSeekerAccountUrl = "/seeker_delete";
  static const String deleteRecruiterAccountUrl = "/recruiter_delete";

  /// CANDIDATE-SECTION
  static const String expectedSalaryUrl = "/salarietype";
  static const String jobTypeUrl = "/jobtype";
  static const String jobDetailUrl = "/seekers/jobs/details/1";
  static const String jobSearchingStatusUrl = "/job_hunting";
  static const String candidateInfoUrl = "/users";
  static const String subjectListUrl = "/subject";
  static const String candidateSaveJobPrefUrl = "/career_preferences";
  //-----------------delete api-------------------------
  static const String deleteSingleJobPrefUrl = "/career_preferences_delete";
  static const String deleteSingleWorkExpUrl = "/workexperience";
  static const String deleteSingleEduQuaUrl = "/education";
  static const String deleteSinglePortfolioUrl = "/protfolio";
  static const String selectLocationUrl = "/location";
  static const String educationLevelUrl = "/education_lavel";
  //-----------------update api-----------------------------
  static const String careerPrefUpdateUrl = "/career_preferences_update";
  static const String educationUpdateUrl = "/education_update";
  static const String workExpUpdateUrl = "/workexperience_update";
  static const String portfolioUpdateUrl = "/protfolio";
  //-------------MY RESUME SECTION----------------
  static const String myResumeUrl = "/profiledetails";
  static const String aboutMeUrl = "/about";
  static const String myPortfolioUrl = "/protfolio";
  static const String myWorkExperienceUrl = "/workexperience";
  static const String educationQualificationUrl = "/education";
  //-------------PROFILE SECTION------------------
  static const String candidateUploadPhotoUrl =
      "/seekers/upload/avatar"; //no needed
  static const String candidateProfileInfoUrl = "/users";
  static const String candidateUploadResumeUrl = "/resume";
  static const String candidateProfileUpdateUrl = "/users";

  ///-----------------jobs url-----------------------
  static const String getjobFilterUrl = "/job_filter";
  static const String jobDetailsUrl = "/single_jobdetails";
  static const String seekerjobsearch = "/job_search";
  static const String jobforyou = "/seeker_joblist";
  static const String seekerFunctionalAreaUrl = "/seeker_expertise";
  static const String nearbyjob = "/seekers/jobs/nearby";
  static const String saveAndUnsavejobUrl = "/job_save";
  static const String viewSavedJobsUrl = "/job_save";
  static const String whoViewedMeUrl = "/who_view_me";
  static const String whoSavedMeUrl = "/who_save_me";
  static const String viewedJobsUrl = "/view_job_history";
  static const String cvSentHistoryUrl = "/send_cv";
  static const String reportJobUrl = "/job_report";
  static const String recruiterCompanyDetailUrl = "/recruiters/company/details";
  static const String updateJobPostUrl = "/job_post_update";
  static const String jobFilterUrl = "/job_filter";
  static const String jobViewCountUrl = "/view_job_count";
  static const String recruiterDetailsUrl = "/recruiter_profilebyid";

  ///-------------------
  static const String companyNameUrl = "/company_search";
  static const String employeeSizeUrl = "/companySize";

  /// RECRUITER-SECTION
  static const String recruiterMainProfileUpdateUrl = "/recruiters_update";
  static const String getrecruiterProfileInfoUrl = "/recruiters_profile";
  static const String recruiterMainProfileUrl = "/recruiters/profile";
  static const String recruiterJobPostUrl = "/job_post";
  static const String experienceListUrl = "/experiencelist";
  static const String recruiterDocVerifyUrl = "/company_verify";
  static const String recruiterIdentyVerifyUrl = "/profile_verify";
  static const String underverificationUrl = "/email_code_verify";
  static const String companyRegistrationUrl = "/company";
  static const String candidateReportUrl = "/candidate_report";
  static const String addfunctionalAreaUrl = "/add_candidate_functional";
  static const String getfunctionalAreaUrl = "/candidate_functionalarea";
  static const String getCandidateListUrl = "/candidatelist";
  static const String candidateSearchUrl = "/candidate_search";
  static const String manageJobsUrl = "/job_post";
  static const String rejectedJobsUrl = "/candidate_reject";
  static const String candidateViewCountUrl = "/candidate_view";
  static const String candidateDetailsUrl = "/candidate_profilebid";
  static const String functionarea_candidatefilter = "/functionarea_candidatefilter";

  //

  static const String jobTitleUrl = "/job_title";
  static const String candidateFilterUrl = "/candidate_filter";
  static const String candidateListUrl = "/candidates";
}

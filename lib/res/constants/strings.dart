
import '../../Hive/hive.dart';
import '../../utils/services/keys.dart';
import 'image_path.dart';

class AppStrings {
  // static final box = GetStorage();
  static var isRecruiter = HiveHelp.read(Keys.isRecruiter);

  /// UNDER VERIFICATION
  static const String underVerificationDes = "Thank you for submitting your work email. Kindly check your mailbox for the confirmation code and enter it below to get verified instantly.";

  /// DELETE ACCOUNT 
  static const String deleteAccEmail = "hello@bringin.io";
  static const String deleteAccTitle = "We sincerely apologize for any inconvenience caused by your decision to leave.";
  static const String deleteAccTitleDes = "If you desire to close your account, you may engage with the Bringin support team by following the outlined process.";
  static const String deleteAccDes1 = "Please send an email to"; 
  static const String deleteAccDes1A = "stating your intention to delete your account from the Bringin database.";
  static const String deleteAccDes2 = "Upon receipt of your account closure request, our team will promptly acknowledge your request and proceed to initiate the account deletion process within 7 working days.";
  static const String deleteAccDes3 = "Once you have confirmed your desire to permanently delete your account, the Bringin team will provide further information regarding the applicable Data Privacy Rights. After a brief processing period, we will proceed to remove all personal and identification data associated with your profile, search results, and user instructions from our system.";

  /// PRIVACY POLICY
  static const String privacyMainDes = "Before accessing or using the Platform, please ensure that you have read and understood our Privacy Policy.";
  
  static const String privacyTitle1 = "1. Information We Collect";
  static const String privacyTitle1A = "A) Information We Collect Through Website:";
  static const String privacyTitle1ADes = "We collect all the information you provide while creating your account, as well as other information that your browser sends whenever you visit our Platform. This information may include your computer's Internet Protocol (IP) address, browser type, browser version, the pages of our Platform that you visit, the time and date of your visit, the time spent on those pages, and other statistics.";
  static const String privacyTitle1B = "B) Information We Collect Through Mobile App Permission:";
  static const String privacyTitle1BDes = "Like our website, we collect all the information you provide on your profile or while creating your account, as well as other permissions that you grant us:";
  
  static const String privacyTitleLocation = "Location: ";
  static const String privacyTitleLocationDes = "If you allow us, we collect your location information so that you can easily find your desired jobs or candidates in your desired location.";
  static const String privacyTitleCamera = "Camera: ";
  static const String privacyTitleCameraDes= "If you allow us, this enables you to give direct interviews via video call.";
  static const String privacyTitleMicrophone = "Microphone: ";
  static const String privacyTitleMicrophoneDes = "If you allow us, this enables you to communicate with recruiters/candidates.";
  static const String privacyTitleContact = "Contacts: ";
  static const String privacyTitleContactDes = "If you allow us, we can help you invite your friends through SMS or WhatsApp.";
  static const String privacyTitleStorage = "Storage: ";
  static const String privacyTitleStorageDes = "If you allow us, this enables you to upload your resume, profile picture, and all other documents needed for your profile.";
  
  static const String privacyTitle2 = "2. How We Use Your Information";
  static const String privacyTitle2Des = "We use the information we collect in various ways, including:";
  static const String privacyTitle2DesList1 = "• Provide, operate, and maintain our application.";
  static const String privacyTitle2DesList2 = "• Improve, personalize, and expand our application.";
  static const String privacyTitle2DesList3 = "• Develop new products, services, features, and functionality.";
  static const String privacyTitle2DesList4 = "• Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes.";
  static const String privacyTitle2DesList5 = "• Send you emails.";
  static const String privacyTitle2DesList6 = "• Find and prevent fraud.";

  static const String privacyTitle3 = "3. Third-Party Services, Tools and SDKs We Used:";
  static const String privacyTitle3A = "A) Payment Gateway: ";
  static const String privacyTitle3ADes = "We use this service to help you accept digital payments and deliver the best payment solutions.";
  static const String privacyTitle3B = "B) Firebase SDK: ";
  static const String privacyTitle3BDes = "We use this to help our web and app to grow.";
  static const String privacyTitle3C = "C) Agora Video SDK: ";
  static const String privacyTitle3CDes = "We use this to help you connect with recruiters/candidates via video call.";
  static const String privacyTitle3D = "D) Sendbird: ";
  static const String privacyTitle3DDes = "We use this to make your message conversations better.";
  
  static const String privacyTitle4 = "4. Third-Party Privacy Policies";
  static const String privacyTitle4Des = "Our Privacy Policy does not apply to otheradvertisers or websites. Thus, we advise you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. This may include their practices and instructions on how to opt-out of certain options. You can choose to disable cookies through your individual browser options. To know more detailed information about cookie management with specific web browsers, it can be found on the browsers' respective websites.";
  
  static const String privacyTitle5 = "5. How Long We Keep Your Personal Data";
  static const String privacyTitle5Des = "We will only keep your personal data as long as necessary to provide you the service on our platform. Afterward, we will retain your information as necessary to comply with legal, accounting, or policy requirements.";
  
  static const String privacyTitle6 = "6. Procedures for Personal Information Disclosure";
  static const String privacyTitle6Des = "The Company does not provide any of your Personal Information to any third party or advertiser. We restrict access to your Personal Information to only those who we believe reasonably need to provide you a job. We do not disclose your personal data to anyone or third party. We may disclose or provide aggregated and anonymous information and analytics about the users of our websites and services to third parties. Before we do so, we will make sure that such information does not identify you.";
  
  static const String privacyTitle7 = "7. Modification of Privacy Policy";
  static const String privacyTitle7Des = "Bringin reserves the right to modify or change the present Privacy Policy without prior notice. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective.";
 
  static const String privacyBottomComment = "If you have any questions about these terms and conditions please contact us at";
  static const String privacyBottomCommentEmailAddr = " hello@bringin.io";
  /// BUY PACKAGE
  static const String buyPackageDes ="Your daily allocation of 6 free chats has been exhausted. To continue chatting with more candidates, kindly purchase a package.";




  
     String welcomeMsg1 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello (candidate name)! I am interested in your profile, Let’s talk in details about the job post."
      : "I would like to learn more about this job position, can we discuss it further?";
   String welcomeMsg2 = HiveHelp.read(Keys.isRecruiter)
      ? "Hey (candidate name), You have a good profile. Can I know your skills, qualifications & experiences in depth?"
      : "Greetings Sir, I am interested in discussing how my skills and experience meet the requirements for the job. Can we talk for a while?";
   String welcomeMsg3 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello <candidate name>, Are you available to response? I'd love to chat with you about our current job openings."
      : "Respectful Greetings Sir, My profile is suitable based on your job post. May I have a moment of your time?";
   String welcomeMsg4 = HiveHelp.read(Keys.isRecruiter)
      ? "Greetings <candidate name>, I am interested in your profile, can we have a talk? Please feel free to knock me back asap!"
      : "Hi, I am confident that my skills and experience make me a good fit for the job. Can we have a quick conversation about it?";
   String welcomeMsg5 = HiveHelp.read(Keys.isRecruiter)
      ? "Hi <candidate name>, I have read your bio. Would you please share me your details CV to learn more about your education & experiences?"
      : "Hi there, I am <name of the seeker>, and I would like to learn more about the job post. Could we schedule a meeting to discuss it further?";
   String welcomeMsg6 = HiveHelp.read(Keys.isRecruiter)
      ? "Hi, Upon reviewing your profile, Found you matched according to our requirements. Are you available for a quick chat now?"
      : "Hello Sir, I am interested in the job opening and I think I have the skills and experience you are looking for. Let’s have a details discussion.";
   String welcomeMsg7 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello, I am interested in your profile. Would you please send me your resume or more details about yourself? "
      : "Hi <name of the recruiter>, Good day! I am interested in discussing the job opening with you. Could we schedule a meeting at your convenience?";
   String welcomeMsg8 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello <candidate name>, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?"
      : "Hello <name of the recruiter>, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?";
  
  
    /// WELCOME MESSAGE PAGE

  late List<String> welcomeMsgList = [
    welcomeMsg1,
    welcomeMsg2,
    welcomeMsg3,
    welcomeMsg4,
    welcomeMsg5,
    welcomeMsg6,
    welcomeMsg7,
    welcomeMsg8,
  ];




  /// RECRUITER JOB POST PAGE
  static const String recruiterJobPostDes = "Note: The job type, job title, and expertise area can’t be changed once the job posting is submitted.";

  /// SUCCESSFULLY JOB POSTED PAGE
  static const String successfullyJobPostedDes1 ="Kindly share your job post within next 60 seconds to gain enhanced visibility and maximize exposure for your position at Bringin.";
  static const String successfullyJobPostedDes2 ="Enhance job visibility and attract a wider pool of candidates by leveraging alternative platforms for sharing your job openings.";
  static const String successfullyJobPostedDes3 ="Once your company and recruiter identity are verified, your job post will be live.";

  /// JOB DESCTIPTION PAGE
  static const String jobDescriptionSubTitle ="Please provide a detail & specific job description to find the right candidate.";

  /// JOB TITLE PAGE
  static const String jobTitleDes ="Enter an accurate job title so that a candidate can understand and you will find the right one.";

  /// OFFER LETTER VERIFY PAGE
  static const String offerLetterVeifyDes ="Click below button to upload your job offer letter  which issued by your company.";

  /// AUTHORIZED DOC VERIFY PAGE
  static const String authorizedDocVerifyDes ="Click below button to upload any other authorized documents provided by the company.";

  /// COMPANY ID CARD VERIFY PAGE
  static const String companyIdCardVeifyDes ="Click below button to upload your ID Card issued which by your company.";

  /// APPOINTMENT LETTER VERIFY PAGE
  static const String appointmentLetterVeifyDes ="Click below button to upload your appointment letter which issued by your company.";

  /// RECRUITER IDENTY EMAIL VERIFY PAGE
  static const String recruiterIdentyEmailVerifyDes ="Click below to enter your work email which was provided by your company domain.";

  /// VERIFICATION CONFIRMATION PAGE
  static const String verificationConfirmationDes ="80% of recruiters will be verified by maximum 30 minutes. The verification process during non-working time may be delayed up to maximum of 12 hours.";
  static const String verificationConfirmationDes2 ="Up to 90% of recruiters will receive a confirmation code within a maximum of 2 minutes. However, during server downtime, the verification process may be delayed for a maximum of 6 hours.";

  /// VERIFY DUMENT PAGE
  static const String verifyDocumentPageDes ="Note: Please check your email and website domain properly which matches with company's official name. If the domain doesn’t match, it might not pass the verification process.";

  /// VERIFY EMAIL PAGE
  static const String verifyEmailPageDes ="Please enter your work email which associate with your company & It’s ensure that you're the current concern of your company.";
  static const String verifyEmailPageRegulationDes ="Note: Please check your email and website domain properly which matches with company's official name. If the domain doesn’t match, it might not pass the verification process.";

  /// VERIFY COMPANY PAGE
  static const String verifyCompanyEmailDes1 ="You can verify faster if you have used your working e-mail address  associate with your company domain.";
  static const String verifyCompanyEmailDes2 ="Note: Please, make sure that your email domain match with the company's official name and domain. If the name doesn't match, it could fail the verification process.";
  static const String verifyCompanyDocDes ="Note: Please, make sure that the name of the documents matches with the entire company name. If the name doesn't match, it could fail the verification process.";

  /// COMPANY LOCATION PAGE
  static const String companyLocationDes ="Mark the precise location of your company on Google Maps and provide the complete address.";
  static const String companyLocationDes1 ="Detailed job location helps the candidates to find your company more easily.";

  /// RECRUITER COMPANY NAME PAGE
  static const String recruiteCompanyNameDes ="Please provide the full legal name of your company exactly as it appears on official documents.";

  /// RECRUITER ENLIST COMPANY NAME PAGE
  static const String enlistCompanyName ="Please provide the required information for enlisted your company with bringin.";

  /// SIGN IN RECRUITER PAGE
  static const String signInRecruiterDes1 ="By proceeding, you agree to Bringin’s ";
  static const String signInRecruiterDes2 ="and confirm that you have read our ";
  static const String signInRecruiterDesSpanText1 = "Terms & ";
  static const String signInRecruiterDesSpanText2 = "Conditions ";
  static const String signInRecruiterDesSpanText3 = "Privacy Policy.";

  /// WHO SAVE ME
  static  String whoSavedMeDes = isRecruiter ?
   "No one has saved your profile yet. Approach more candidates and find your desire employee." :
   "No one has saved your profile yet. Approach more recruiters and find your dream job";

  /// WHO VIEWED ME
  static  String whoViewedMeDes = isRecruiter ?
   "No one has viewed your profile yet. Approach more candidates and find your desire employee." :
   "No one has viewed your profile yet. Approach more recruiters and find your dream job";

  /// MY RESUME PAGE
  static const String myResumeHeader ="A complete profile attracts more recruiters attention.";

  /// ADD CV
  static const String addCvDes ="Please upload your cv/resume in PDF format and the file size should not exceed 5 MB.";
  static const String addCvDes2 ="You may send your CV or resume to a recruiter during your conversation only if you choose to do so via Bringin App.";

  /// EXPERTISE AREA PAGE
  static String expertiseAreaDes = isRecruiter
      ? "Please choose an expertise area for us to match you with relevant job options."
      : "Select an expertise area will help us to match you with relevant job postings.";

  /// JOB INDUSTRY PAGE
  static String jobIndustryDes = isRecruiter
      ? "Please select the industry field that corresponds to your company."
      : "What kind of job do you prefer?";

  /// SETTINGS PAGE
  static const String signInDescription ="If you’re registered, you’ll login automatically after OTP verification.";
  
  static const String smsNotificationsDes = "Turn on SMS notifications for unread messages.";
  static String sMSRecommendationsDes = isRecruiter
      ? "Turn on SMS notifications to receive AI-matched candidate recommendations."
      :"Turn on SMS notifications to receive AI-matched job recommendations.";
  static String pushNotificationDes = isRecruiter
      ? "Turn on push notifications for candidate recommendations."
      : "Turn on push notifications for job-based position recommendations.";
  static String whatsappNotifications = isRecruiter ?
  "Enable push alerts for new candidate recommendations via WhatsApp." :
   "Enable job-based push alerts for new position recommendations via WhatsApp.";
  
  /// ABOUT PAGE DESCRIPTION
  static const String aboutDes1 = "Bringin Technologies Limited started it’s journey on June 2023, is an AI-powered first chat-based instant hiring app which has specially designed for the Startups and SMEs in Bangladesh.";
  static const String aboutDes2 = "The application aims to streamline the hiring process by providing a quick efficient way for companies to connect with job seekers.";
  
  /// JOB PREFERENCE PAGE
  static const String profileCompletionDes ="Adding another career preference will increase your profile visibility.";

  /// TERMS & CONDITIONS PAGE
  static const String termsDes ="Thank you for using Bringin mobile and web application services. Please read this page carefully, these Terms and Conditions govern the conditions of use of all services provided by the Company (“Services”) and apply to all customers who use the Services:";

  static const String rules1 ="These Terms and Conditions (Amended from time to time by Bringin), together with your Advertising and Candidate Search Service Agreement (if applicable), form a binding agreement (the \"Agreement\") between you and Bringin. Your access to or use of the Bringin Web Sites or Services indicates your acceptance of these Terms and Conditions. You are agreeing to use the Sites at your own risk.";
  static const String rules2 ="Our website or mobile app may contain links, websites or social media accounts of the users. Which are not owned by us. So we do not take any responsibility for any third party sites which is provided by its users. Therefore, use or access those links or sites at your own risk. Moreover, since we do not verify all the sites that the job candidates provide in their CV or while you are contact with them, you should use them at your own risk. Bringin does not take any responsibility of those. But you are encouraged to read these terms before using our website or service.";

  static const String rules3A ="When you create your account as a recruiter, you must ensure that the information you provided is 100% correct. Because you have to bear the responsibility of the information of your company or service. Bringin will not be liable for any kind of illegal aspects that you have inputted. If you try to provide any false information, we will immediately terminate your account. You will be responsible for any loss we or anyone else suffers as a result of any false information you provide. Moreover, you will bear the confidentiality of all your information.";
  static const String rules3B ="When you open an account as a job seeker or present yourself for an interview, ensure that all the information you provide in your profile is correct. You are solely responsible for the information provided in your account. Bringin will not bear any responsibility.";

  static const String rules4A ="A) Bringin owns the full rights to any images, content or anything else you upload. Bringin reserves the right to delete or store any of that content if needed.";
  static const String rules4B ="B) Copyrights and Intellectual Property Rights of all information provided by Bringin (such as contents and information) belong to Bringin Technologies Limited. However, information such as product name, company name and logos include trademarks and registered trademarks possessed by each company.";
  static const String rules4C ="C) If any recruiter or job seeker provide any links of external sites administered by third parties. Bringin shall not be held responsible for the availability or content of external sites.";
  static const String rules4D ="D) You shall not post/upload/transmit/share any contents that is unlawful, discriminatory, fraudulent, harassing,   fake, Spam, scam, infringing, etc.";

  static const String rules5First ="This site contains various properties and elements like graphics, content, bringin is owner of those things. The service is protected by copyright, trademark, and other laws of Bangladesh. Any of our assets or service may not be use elsewhere without our prior permission.";
  static const String rules5Middle ="How ever a user or anyone use the content or anything of Bringin for personal or commercial use in that case he has to clearly include the copyright, trademark and have to provide link to the original web page and will have to agree that Bringin is the sole owner of all the properties of this site and services.";
  static const String rules5Last ="If someone bothering you then you should send appropriate evidence (Screenshot, video or audio) about the circumstances. We will verify and if it violates any of our policy, then we will definitely take legal action against him. Anyone can also report for spam, scam, fraud, or etc.";

  static const String rules6 ="We usually collect your personal data from the information you submit during the time of creating account. This will typically be through the forms and documents used when you create your account with us or sign up to Bringin. We may collect your name, phone number, email id, pin code, your location, your company profile, Resumes and others information you provide when you sign up to your account or from your job advertisement.";

  static const String rules7First ="At Bringin, we collect and use your personal data to provide and improve our Service, comply with legal obligations, and for other legitimate business purposes. We may use your personal data to:";
  static const String rules7A = "A) Verify your identity.";
  static const String rules7B = "B) Provide access to the Service.";
  static const String rules7C ="C) Communicate with you about your account and the Service.";
  static const String rules7D = "D) Respond to your inquiries and requests.";
  static const String rules7E = "E) Improve and personalize the Service.";
  static const String rules7F = "F) Conduct research and analysis.";
  static const String rules7G = "G) Comply with legal obligations.";
  static const String rules7Last ="We take the protection of your personal data seriously and have implemented appropriate technical and organizational measures to ensure its security. We will only retain your personal data for as long as necessary to fulfill the purposes for which it was collected or as required by law. You have the right to request access to, rectification or deletion of your personal data, as well as the right to object to and restrict its processing. If you have any questions or concerns about our use of your personal data, please contact us.";

  static const String rules8First ="We are committed to safeguarding and protecting your personal data and will implement and maintain appropriate technical and organizational measures to ensure a level of security to protect your data secured from accidental or unauthorized destruction, loss, alteration, disclosure or access.";
  static const String rules8Last ="Bringin never disclose your data to any third-party agency without your authorization.";

  static const String rules9First ="Bringin is Bangladesh’s direct first chat-based instant hiring platform. Through bringin app we’re connecting job seekers and recruiters in Bangladesh. Our Service is completely free for job seekers. But for the Recruiters who are looking for the exact AI-matched relevant candidate for their company, will get a 3 day trial for 12 chat initiations. After that, they will upgraded to a freemium plan of 04 free chats a day.";
  static const String rules9Second ="Recruiters can choose between the different plan options to connect with more candidates on bringin. Payments are made monthly as per the selected plan.";
  static const String rules9Third ="We take pride in offering highly competitive prices eithin the market, taking into caeful consideration the exceptional quality and value of our services.";

  static const String rules10 ="A valid in web & app payment method, including MFS, Internet Banking & SSLCOMMERZ supported Card Services is required to process the payment for your subscription. You shall provide Bringin with the accurate billing information including full name, address, number and a valid payment method. Should automatic billing fail to occur for any reason, Bringin will issue an instruction that you must proceed manually.";

  static const String rules11 ="We understand that circumstances may change, and you may need to cancel your subscription with Bringin. Therefore, we have implemented a cancellation policy to ensure a smooth process for our users.";
  static const String rules11ATitle ="A) Subscription Cancellation:";
  static const String rules11ADes ="You have the freedom to cancel your subscription with Bringin at any time and switch back to the free model. To initiate the cancellation, please follow the steps outlined below:";
  static const String rules11AList1 ="Log in to your Bringin account.";
  static const String rules11AList2 ="Go to the Account Settings or Subscription section.";
  static const String rules11AList3 ="Locate the cancellation option and follow the provided instructions.";

  static const String rules11BTitle ="B) Effect of Cancellation:";
  static const String rules11BDes ="Upon canceling your subscription, the following effects will take place:";
  static const String rules11BList1 ="Your subscription will be terminated immediately.";
  static const String rules11BList2 ="You will no longer have access to the premium features associated with your subscription plan.";
  static const String rules11BList3 ="Any remaining chat initiations or benefits provided by the subscription plan will cease.";
  
  static const String rules11CTitle ="C) Reverting to Free Model:";
  static const String rules11CDes ="After canceling your subscription, you will automatically revert to the free model offered by Bringin. As a Job Seeker or Recruiter, you can continue to enjoy our services free of charge what we offered usually. However, certain limitations and restrictions may apply to the features and benefits available in the free model.";
  
  static const String rules11DTitle ="D) Modification or Termination of Cancellation Policy:";
  static const String rules11DDes1 ="Bringin reserves the right to modify or terminate the cancellation policy at any time. In the event of any changes, we will notify users through our website, app notifications, WhatsApp or other appropriate communication channels.";
  static const String rules11DDes2 ="For further assistance or inquiries regarding subscription cancellation, please contact our support team. Please note that this cancellation policy is subject to the Terms and Conditions outlined on our website and may be updated or revised as necessary. It is your responsibility to review and comply with the latest version of our cancellation policy.";
  
  static const String rules12Title = "12. Refund Policy of Bringin Technologies Limited";
  static const String rules12Des = "At Bringin, we strive to provide a seamless and satisfactory experience to all our users. However, please note that our refund policy for the subscription model is as follows:";
  
  static const String rules12ATitle = "A) Digital Offering and Refund Eligibility:";
  static const String rules12ADes= "The subscription model offered by Bringin is a digital service. Once the payment for the subscription has been completed, Bringin generally does not provide refunds unless specific circumstances arise.";
  
  static const String rules12BTitle = "B) Refund Requests:";
  static const String rules12BDes= "Refund requests will only be considered under the following conditions;";
  static const String rules12BListTitle= "Platform Failure:";
  static const String rules12BListDes= "If, after exercising due diligence, it is determined that the subscription service cannot be utilized due to a platform failure or technical issue on Bringin's part, the user may be eligible for a refund. In such cases, the user should reach out to our customer support team to initiate the refund process.";
  
  static const String rules12CTitle = "C) Non-Refundable Situations:";
  static const String rules12CDes= "Please be aware that refunds will not be issued in the following situations;";
  static const String rules12CListTitle= "Inappropriate Behavior:";
  static const String rules12CListDes= "If a user's account is closed due to inappropriate behavior on Bringin's platform, no refund will be provided.";
  
  static const String rules12DTitle = "D) Contacting Customer Support:";
  static const String rules12DDes1= "If you have any concerns or objections regarding the subscription or refund, we encourage you to contact Bringin's customer support team. Our team will be available to address your queries and assist you in the best possible way.";
  static const String rules12DDes2= "Please note that this refund policy is subject to the Terms and Conditions outlined on our website. Bringin reserves the right to modify or amend the refund policy at any time. Any updates or changes to the refund policy will be communicated through our website or other appropriate channels. If you have any further questions or require assistance, please don't hesitate to reach out to our customer support team. It is important to review and comply with the latest version of our refund policy as stated on our website.";

  static const String rules13First ="We may terminate or suspend your account, without prior notice or liability, for any reason, including limitation if you breach the terms. Upon termination, your right to use the service shall immediately cease. If you wish to terminate your account you may simply discontinue using the service.";
  static const String rules13Middle ="If you have any more questions about bringin terms and condition please contact us at ";
  static const String rules13Last = "hello@bringin.io";



  /// EXAMPLES OF MY BIO PAGE
  static const String myBioExAva1 = AppImagePaths.avatar1;
  static const String myBioExAva2 = AppImagePaths.avatar2;
  static const String myBioExAva3 = AppImagePaths.avatar3;
  static const String myBioExAva4 = AppImagePaths.avatar4;
  static const String myBioExAva5 = AppImagePaths.avatar5;

  static const String aboutMeExProf1 = "Android Developer";
  static const String aboutMeExProf2 = "UI / UX";
  static const String aboutMeExProf3 = "Digital Marketing";
  static const String aboutMeExProf4 = "Data Analyst";
  static const String aboutMeExProf5 = "Product Manager";

  static const String aboutMeExDes1 ="I have completed my M.Tech in CSE from Dhaka University. | have been working as an Android Developer for the last 3 years. I have developed a P2P Payment App and a Regional News App. My core skills include Java Programming, XML, Android SDK, Android Studio, Material Design and APIs.";
  static const String aboutMeExDes2 ="I have done my bachelor in Design from AIUB. I have done my Summer Internship in Bringin as a User Experience Designer. I am looking for an opportunity in the field of UI/UX Design. I am skilled at In Vision, Sketch, Adobe, Axure, Framer, and Webflow.";
  static const String aboutMexDes3 ="I have 4 years of experience in Digital Marketing. I have mastered Facebook Ads Campaign, Google Ads Campaign, and Influencer Marketing. I have promoted a dating App on Social Media and reduced the CPI from Rs 9.00 to Rs 4.00. Scaled up the Marketing results to 8X in 2 years.";
  static const String aboutMeExDes4 ="I have been working as a Data Analyst in IT companies for the last 3 years. Increased the Day 1 retention of a Short video app by 12% by improving the content recommendation algorithm. Some of my core skills include R Programming, Python, SQL, Hadoop, Regression Model, HIVE.";
  static const String aboutMeExDes5 ="A Passionate Product Manager with 3 years of experience to build mobile apps from scratch. My 1st mobile App has acquired 20 Mn+ Installs within 1.5 years with CPI < Rs 2.00. | have monitored User-Centric Product Development, User Acquisition, Retention, and Monetization.";

 
}

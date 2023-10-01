
import '../../res/constants/image_path.dart';
import '../../Screens/candidate_section/bottom_nav/candidates/candidates_screen.dart';
import '../../Screens/candidate_section/bottom_nav/jobs/jobs_screen.dart';
import '../../Screens/candidate_section/bottom_nav/candidate_main_profile/candidate_main_profile_screen.dart';
import '../../Screens/messages/candidate_message/message_page.dart';
import '../../Screens/messages/recruiter_message/recruiter_message_page.dart';
import '../../Screens/recruiter_section/recruiter_main_profile/recruiter_main_profile_screen.dart';
import 'keys.dart';

class BottomNavData {

  // /// PAGE LIST
  //  List widgetOptions = [
  //   box.read(Keys.isRecruiter) == true ? CandidatesScreen() : JobScreen(),
  //   box.read(Keys.isRecruiter) == true ? RecuiterMessageScreen() : MessageScreen(),
  //   box.read(Keys.isRecruiter) == true ? RecruiterMainProfileScreen() : CandidateMainProfileScreen(),
  // ];
  
  /// BOTTOM NAV ICON LIST
  //  List<String> iconList = <String>[
  //   box.read(Keys.isRecruiter) == true ? AppImagePaths.candidates : AppImagePaths.jobsIcon,
  //   AppImagePaths.messageIcon,
  //   AppImagePaths.profile_icon,
  // ];

  /// ICON LIST WHEN PRESS ON IT
  //  List<String> iconList1 = <String>[
  //   box.read(Keys.isRecruiter) == true ? AppImagePaths.candidates1 : AppImagePaths.jobs1,
  //   AppImagePaths.message1Icon,
  //   AppImagePaths.profile_icon1,
  // ];

  /// BOTTOM NAV TEXT LIST
  //  List<String> textList = <String>[
  //   box.read(Keys.isRecruiter) == true ? "Candidates" : "Get Jobs",
  //   "Chats",
  //   "My Profile",
  // ];
}

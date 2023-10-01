// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:bringin/utils/services/keys.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';

// class SeekerVideoCall extends StatefulWidget {
//   final Groupchannel groupchannel;

//   const SeekerVideoCall({super.key, required this.groupchannel});

//   @override
//   State<SeekerVideoCall> createState() => _SeekerVideoCallState();
// }

// class _SeekerVideoCallState extends State<SeekerVideoCall> {
//   late final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: Keys.agora_appid,
//       channelName: "${widget.groupchannel.channelid}",
//     ),
//   );

// // Initialize the Agora Engine
//   @override
//   void initState() {
//     super.initState();
//     print("hsvcsdv");
//     initAgora();
//   }

//   void initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               AgoraVideoViewer(client: client),
//               AgoraVideoButtons(
//                 client: client,
//                 autoHideButtonTime: 5,
//                 onDisconnect: () {
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

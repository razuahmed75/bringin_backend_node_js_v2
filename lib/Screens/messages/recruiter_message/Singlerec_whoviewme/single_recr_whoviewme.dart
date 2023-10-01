import 'package:flutter/material.dart';

import '../../../../Hive/hive.dart';
import '../../../../Http/get.dart';
import '../../../../models/Chat/channelinfo.dart';
import '../../../../utils/services/keys.dart';
import '../components/recruiter_who_viewed_me_tab.dart';

class SingleRecWhoViewme extends StatefulWidget {
  final ChannelInfo data;
  const SingleRecWhoViewme({super.key, required this.data});

  @override
  State<SingleRecWhoViewme> createState() => _SingleRecWhoViewmeState();
}

class _SingleRecWhoViewmeState extends State<SingleRecWhoViewme> {
  Future resetwhoviewme() async {
    var data =
        await Httphelp.get(ENDPOINT_URL: "/whoviewme_reset?isrecruiter=true");
    print("dkvsdvbsdv ${data.body}");
  }

  @override
  void initState() {
    if (widget.data.whoViewMe!.newview! > 0) {
      resetwhoviewme();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Who viewed me",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: RecruiterWhoViewedMeTab(),
    );
  }
}

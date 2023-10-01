import 'package:bringin/Hive/hive.dart';
import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/keys.dart';
import 'package:flutter/material.dart';

import '../../../../models/Chat/channelinfo.dart';
import '../components/candidate_who_viewed_me_tab.dart';

class SingleWhoViewMe extends StatefulWidget {
  final ChannelInfo data;
  const SingleWhoViewMe({super.key, required this.data});

  @override
  State<SingleWhoViewMe> createState() => _SingleWhoViewMeState();
}

class _SingleWhoViewMeState extends State<SingleWhoViewMe> {
  Future resetwhoviewme() async {
    var data = await Httphelp.get(
        ENDPOINT_URL:
            "/whoviewme_reset?isrecruiter=${HiveHelp.read(Keys.isRecruiter)}");

    print(data.body);
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
      body: CandidateWhoViewedMeTab(),
    );
  }
}

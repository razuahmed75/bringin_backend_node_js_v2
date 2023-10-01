import 'package:bringin/utils/services/keys.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/recent_candidate_search_model.dart';
import '../models/recent_job_search_model.dart';
import 'hive_collection_var.dart';

  Future initHive() async{
    await Hive.initFlutter();
    final dir = await getApplicationDocumentsDirectory();
    Hive
    ..init(dir.path)
    ..registerAdapter(RecentJobSearchModelAdapter())
    ..registerAdapter(RecentCandidateSearchModelAdapter()); 
    await Hive.openBox(Keys.hiveinit);
    recentBox = await Hive.openBox<RecentJobSearchModel>(Keys.recentJobSearch);
    recentBox2 = await Hive.openBox<RecentCandidateSearchModel>(Keys.recentCandidateSearch);
  }

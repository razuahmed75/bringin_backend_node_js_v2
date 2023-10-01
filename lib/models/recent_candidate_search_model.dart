import 'package:hive/hive.dart';
part 'recent_candidate_search_model.g.dart';

@HiveType(typeId: 2)
class RecentCandidateSearchModel{
  RecentCandidateSearchModel({required this.candidateName, required this.city});

  @HiveField(0)
  String candidateName;

  @HiveField(1)
  String city;

}

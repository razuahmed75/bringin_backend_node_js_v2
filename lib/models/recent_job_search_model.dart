import 'package:hive/hive.dart';
part 'recent_job_search_model.g.dart';

@HiveType(typeId: 1)
class RecentJobSearchModel{
  RecentJobSearchModel({required this.jobTitle, required this.city, required this.division});

  @HiveField(0)
  String jobTitle;

  @HiveField(1)
  String city;

  @HiveField(2)
  String division;

}

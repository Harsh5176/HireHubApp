import 'package:get/get.dart';

class JobModel {
  final String slug;
  final String title;
  final String companyName;
  final String location;
  final String description;
  final String url;
  RxBool isBookmarked;

  JobModel({
    required this.slug,
    required this.title,
    required this.companyName,
    required this.location,
    required this.description,
    required this.url,
    bool initialBookmark = false,
  }) : isBookmarked = initialBookmark.obs;

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      slug: json['slug'] ?? '',
      title: json['title'] ?? 'No Title',
      companyName: json['company_name'] ?? 'Unknown Company',
      location: json['location'] ?? 'Remote',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class ApiService {
  static const String baseUrl = 'https://www.arbeitnow.com/api/job-board-api';

  Future<List<JobModel>> fetchJobs() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List jobsData = data['data']; // 'data' is the key in ArbeitNow API
      return jobsData.map((json) => JobModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
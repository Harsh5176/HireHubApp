import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';
import '../services/api_service.dart';

class JobController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var allJobs = <JobModel>[].obs;
  var filteredJobs = <JobModel>[].obs;
  var isDarkMode = false.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchJobs();
    super.onInit();
  }

  void fetchJobs() async {
    try {
      isLoading(true);
      errorMessage('');
      var jobs = await _apiService.fetchJobs();
      allJobs.assignAll(jobs);
      filteredJobs.assignAll(jobs);
    } catch (e) {
      errorMessage.value = "Failed to load: $e";
    } finally {
      isLoading(false);
    }
  }

  void searchJobs(String query) {
    if (query.isEmpty) {
      filteredJobs.assignAll(allJobs);
    } else {
      filteredJobs.assignAll(allJobs.where((job) =>
      job.title.toLowerCase().contains(query.toLowerCase()) ||
          job.companyName.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
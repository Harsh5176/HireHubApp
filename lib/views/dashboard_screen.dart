import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../models/job_model.dart';
import 'job_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final JobController controller = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HireHub", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Obx(() => IconButton(
            icon: Icon(controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: controller.toggleTheme,
          )),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: controller.searchJobs,
              decoration: InputDecoration(
                hintText: 'Search jobs...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF30363D) : Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.errorMessage.isNotEmpty) return Center(child: Text(controller.errorMessage.value));

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.filteredJobs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => JobCard(job: controller.filteredJobs[index]),
        );
      }),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobModel job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Get.to(() => JobDetailScreen(job: job)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D2226) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(job.companyName, style: TextStyle(color: Colors.blue[700])),
                  const SizedBox(height: 4),
                  Text(job.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Obx(() => IconButton(
              icon: Icon(job.isBookmarked.value ? Icons.favorite : Icons.favorite_border, color: Colors.red),
              onPressed: job.isBookmarked.toggle,
            )),
          ],
        ),
      ),
    );
  }
}
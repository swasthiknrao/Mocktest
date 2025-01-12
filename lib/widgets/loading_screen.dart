import 'package:flutter/material.dart';
import '../widgets/skeleton_loading.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F9FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Profile section
            Row(
              children: [
                const SkeletonLoading(
                  width: 50,
                  height: 50,
                  borderRadius: 25,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonLoading(
                      width: 120,
                      height: 24,
                    ),
                    SizedBox(height: 8),
                    SkeletonLoading(
                      width: 100,
                      height: 16,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Daily Practice Card
            const SkeletonLoading(
              height: 180,
              borderRadius: 16,
            ),
            const SizedBox(height: 24),
            // Create Test Card
            const SkeletonLoading(
              height: 80,
              borderRadius: 16,
            ),
            const SizedBox(height: 24),
            // Recent Tests
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: const SkeletonLoading(
                    width: 160,
                    height: 200,
                    borderRadius: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/slide_route.dart';
import '../screens/home_screen.dart';
import '../screens/exam_prepare_screen.dart';
import '../screens/test_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/stats_screen.dart';
import '../models/test_model.dart';

class SharedBottomNav extends StatelessWidget {
  final int currentIndex;
  static const Color kPrimaryBlue = Color(0xFFAED8D7);

  const SharedBottomNav({super.key, required this.currentIndex});

  void _handleNavigation(BuildContext context, int index) {
    if (index == currentIndex) return;

    String routeName;
    dynamic arguments;

    switch (index) {
      case 0:
        routeName = '/home';
        break;
      case 1:
        routeName = '/exam-prepare';
        break;
      case 2:
        routeName = '/test';
        arguments = TestModel(
          title: 'Practice Test',
          questions: [
            Question(
              id: '1',
              questionText: 'Sample Question 1?',
              correctOptionId: 'a',
              options: [
                Option(id: 'a', text: 'Option A'),
                Option(id: 'b', text: 'Option B'),
                Option(id: 'c', text: 'Option C'),
                Option(id: 'd', text: 'Option D'),
              ],
            ),
          ],
        );
        break;
      case 3:
        routeName = '/learn';
        break;
      case 4:
        routeName = '/stats';
        break;
      default:
        return;
    }

    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 0, Icons.home_outlined, 'Home'),
            _buildNavItem(context, 1, Icons.book_outlined, 'Exam Prepare'),
            _buildNavItem(context, 2, Icons.assignment_outlined, 'Test'),
            _buildNavItem(context, 3, Icons.local_library_outlined, 'Learn'),
            _buildNavItem(context, 4, Icons.pie_chart_outline, 'Stats'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => _handleNavigation(context, index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: kPrimaryBlue.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? kPrimaryBlue : Colors.grey.shade500,
                size: 20,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: kPrimaryBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

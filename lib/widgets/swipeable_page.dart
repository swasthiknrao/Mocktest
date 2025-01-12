import 'package:flutter/material.dart';
import 'shared_bottom_nav.dart';
import '../models/test_model.dart';

class SwipeablePage extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const SwipeablePage({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == 0) return;

        if (details.primaryVelocity! > 0) {
          // Swipe right - go to previous page
          if (currentIndex > 0) {
            Navigator.pushReplacementNamed(
              context,
              _getRoute(currentIndex - 1),
              arguments: _getArguments(currentIndex - 1),
            );
          }
        } else {
          // Swipe left - go to next page
          if (currentIndex < 4) {
            Navigator.pushReplacementNamed(
              context,
              _getRoute(currentIndex + 1),
              arguments: _getArguments(currentIndex + 1),
            );
          }
        }
      },
      child: Scaffold(
        body: child,
        bottomNavigationBar: SharedBottomNav(currentIndex: currentIndex),
      ),
    );
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/exam-prepare';
      case 2:
        return '/test';
      case 3:
        return '/menu';
      case 4:
        return '/stats';
      default:
        return '/home';
    }
  }

  dynamic _getArguments(int index) {
    if (index == 2) {
      return TestModel(
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
    }
    return null;
  }
}

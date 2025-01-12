import 'package:flutter/material.dart';
import '../widgets/swipeable_page.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeablePage(
      currentIndex: 4,
      child: Scaffold(
        body: const Center(
          child: Text('Stats Screen'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/shared_bottom_nav.dart';
import '../widgets/swipeable_page.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeablePage(
      currentIndex: 3,
      child: Scaffold(
        body: const Center(
          child: Text('Menu Screen'),
        ),
      ),
    );
  }
}

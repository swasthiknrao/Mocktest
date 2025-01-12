import 'package:flutter/material.dart';
import 'shared_bottom_nav.dart';

class PageWithNav extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const PageWithNav({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: child,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SharedBottomNav(currentIndex: currentIndex),
        ),
      ],
    );
  }
}

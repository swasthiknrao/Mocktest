import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final bool slideFromRight;

  SlidePageRoute({required this.page, this.slideFromRight = true})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Main page slide animation
            var begin = Offset(slideFromRight ? 1.0 : -1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOutCubic;

            var tween = Tween(begin: begin, end: end);
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            // Previous page slide animation
            var secondaryBegin = Offset.zero;
            var secondaryEnd = Offset(slideFromRight ? -0.3 : 0.3, 0.0);
            var secondaryTween =
                Tween(begin: secondaryBegin, end: secondaryEnd);

            return Stack(
              children: [
                // Previous page sliding out
                SlideTransition(
                  position: secondaryTween.animate(curvedAnimation),
                  child: child,
                ),
                // New page sliding in
                SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                ),
              ],
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          maintainState: true,
          opaque: false,
        );
}

import 'package:flutter/material.dart';

/// DotLoadingIndicator is a reusable widget that displays a row of animated dots,
/// often used as a loading indicator. The size of the dots can be adjusted, and
/// the animation provides a fade-in, fade-out effect.
class DotLoadingIndicator extends StatefulWidget {
  const DotLoadingIndicator({super.key});

  @override
  State<DotLoadingIndicator> createState() => _DotLoadingIndicatorState();
}

class _DotLoadingIndicatorState extends State<DotLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;  // Controller for the animation
  late Animation<double> _animation;     // Animation for the fade transition

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 1000ms and set it to repeat
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    // Define the animation as a tween between 0 and 1
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              // Each dot fades in and out at a slightly different interval
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(index / 3.0, (index + 1) / 3.0),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),  // Increase spacing between dots
                  width: 60.0,  // Increased size for larger dots
                  height: 60.0, // Increased size for larger dots
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,      // Circular shape for each dot
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

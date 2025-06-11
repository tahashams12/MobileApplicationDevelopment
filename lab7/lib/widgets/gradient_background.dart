import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF121212),
                  const Color(0xFF1A1A2E),
                ]
              : [
                  const Color(0xFFF8FAFF),
                  const Color(0xFFEDF1FB),
                ],
        ),
      ),
      child: child,
    );
  }
}

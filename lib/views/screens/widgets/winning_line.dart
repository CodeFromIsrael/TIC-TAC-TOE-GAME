import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';

class WinningLine extends StatelessWidget {
  final Offset start;
  final Offset end;

  const WinningLine({required this.start, required this.end, super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return CustomPaint(
          painter: WinningLinePainter(
            start: start,
            end: end,
            progress: value,
          ),
        );
      },
    );
  }
}

class WinningLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double progress;

  WinningLinePainter(
      {required this.start, required this.end, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blueColor
      //..style = PaintingStyle.fill
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final currentEnd = Offset(
      start.dx + (end.dx - start.dx) * progress,
      start.dy + (end.dy - start.dy) * progress,
    );

    canvas.drawLine(start, currentEnd, paint);
  }

  @override
  bool shouldRepaint(covariant WinningLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

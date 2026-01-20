import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';

class WavyContainer extends StatelessWidget {
  final PositionWavy postionWavy;
  final Widget? child;
  final double? heith;

  const WavyContainer(
      {super.key, required this.postionWavy, this.child, this.heith});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: postionWavy == PositionWavy.top
            ? WavyTopPainter()
            : WavyBottomPainter(),
        size: const Size(double.infinity, 150),
        child: child);
  }
}

class WavyTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blueColor
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.3,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.2, size.height * 0.7, 0, size.height * 0.5);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavyTopPainter oldDelegate) => false;
}

class WavyBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blueColor
      ..style = PaintingStyle.fill;

    final path = Path();
    canvas.save();

    canvas.translate(0, size.height);
    canvas.scale(1, -1);

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.3,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.7, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum PositionWavy { top, bottom }

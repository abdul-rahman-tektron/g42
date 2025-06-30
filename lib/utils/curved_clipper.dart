import 'package:flutter/material.dart';

class DoubleWaveHeader extends StatelessWidget {
  final double height;
  final Color frontWaveColor;
  final Color backWaveColor;
  final Widget? child;

  const DoubleWaveHeader({
    super.key,
    required this.height,
    required this.frontWaveColor,
    required this.backWaveColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Back wave
          ClipPath(
            clipper: _BottomWaveClipper2(),
            child: Container(
              color: backWaveColor,
            ),
          ),
          // Front wave
          ClipPath(
            clipper: _BottomWaveClipper1(),
            child: Container(
              color: frontWaveColor,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// FRONT WAVE
class _BottomWaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);

    path.quadraticBezierTo(
      size.width / 4, size.height,
      size.width / 2, size.height - 30,
    );
    path.quadraticBezierTo(
      size.width * 3 / 4, size.height - 60,
      size.width, size.height - 30,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// BACK WAVE
class _BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final offset = 20.0;
    final path = Path();

    path.lineTo(0, size.height - 50 + offset);

    path.quadraticBezierTo(
      size.width / 4, size.height - 80 + offset,
      size.width / 2, size.height - 50 + offset,
    );
    path.quadraticBezierTo(
      size.width * 3 / 4, size.height - 20 + offset,
      size.width, size.height - 50 + offset,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

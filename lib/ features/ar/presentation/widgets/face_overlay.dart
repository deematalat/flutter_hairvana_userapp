import 'package:flutter/material.dart';
import '../../domain/entities/detected_face.dart';

class FaceOverlay extends StatelessWidget {
  final List<DetectedFace> faces;
  final Size screenSize;

  const FaceOverlay({required this.faces, required this.screenSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (faces.isEmpty) return const SizedBox.shrink();
    
    return IgnorePointer(
      child: CustomPaint(
        painter: _FaceOverlayPainter(faces: faces, screenSize: screenSize),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _FaceOverlayPainter extends CustomPainter {
  final List<DetectedFace> faces;
  final Size screenSize;

  _FaceOverlayPainter({required this.faces, required this.screenSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple.withOpacity(0.3);

    for (final face in faces) {
      final rect = Rect.fromLTWH(
        face.left * screenSize.width / 480,
        face.top * screenSize.height / 640,
        face.width * screenSize.width / 480,
        face.height * screenSize.height / 640,
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 
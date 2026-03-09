import 'package:flutter/material.dart';
import 'package:smart_trainer/theme/app_colors.dart';

class SkeletonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // This is a placeholder for the 33-point MediaPipe/MoveNet skeleton.
    // It draws a static mock skeleton for UI visualization purposes.
    
    final paintLine = Paint()
      ..color = AppColors.electricBlue.withOpacity(0.6)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final paintNode = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.fill;
      
    final paintNodeOutline = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // A few mock points mimicking a human figure (head, shoulders, elbows, hands, hips, knees, feet)
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    
    // Nodes
    final head = Offset(cx, cy - 150);
    final lShoulder = Offset(cx - 50, cy - 80);
    final rShoulder = Offset(cx + 50, cy - 80);
    final lElbow = Offset(cx - 80, cy - 20);
    final rElbow = Offset(cx + 80, cy - 20);
    final lHand = Offset(cx - 70, cy + 40);
    final rHand = Offset(cx + 70, cy + 40);
    final lHip = Offset(cx - 30, cy + 60);
    final rHip = Offset(cx + 30, cy + 60);
    final lKnee = Offset(cx - 40, cy + 150);
    final rKnee = Offset(cx + 40, cy + 150);
    final lFoot = Offset(cx - 50, cy + 240);
    final rFoot = Offset(cx + 50, cy + 240);

    // Draw connections (bones)
    canvas.drawLine(head, Offset(cx, cy - 80), paintLine); // Neck
    canvas.drawLine(lShoulder, rShoulder, paintLine); // Shoulders
    canvas.drawLine(lShoulder, lElbow, paintLine);
    canvas.drawLine(rShoulder, rElbow, paintLine);
    canvas.drawLine(lElbow, lHand, paintLine);
    canvas.drawLine(rElbow, rHand, paintLine);
    canvas.drawLine(Offset(cx, cy - 80), Offset(cx, cy + 60), paintLine); // Spine
    canvas.drawLine(lHip, rHip, paintLine); // Pelvis
    canvas.drawLine(lHip, lKnee, paintLine);
    canvas.drawLine(rHip, rKnee, paintLine);
    canvas.drawLine(lKnee, lFoot, paintLine);
    canvas.drawLine(rKnee, rFoot, paintLine);

    // Draw nodes (joints)
    final nodes = [
      head, lShoulder, rShoulder, lElbow, rElbow, lHand, rHand,
      lHip, rHip, lKnee, rKnee, lFoot, rFoot
    ];

    for (var node in nodes) {
      canvas.drawCircle(node, 6.0, paintNode);
      canvas.drawCircle(node, 6.0, paintNodeOutline);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

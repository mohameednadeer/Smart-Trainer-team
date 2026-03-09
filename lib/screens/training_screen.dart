import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trainer/theme/app_colors.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Grid
          CustomPaint(
            size: Size.infinite,
            painter: GridPainter(),
          ),

          // 2. Corner Brackets Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomPaint(
                painter: CornerBracketsPainter(
                  color: AppColors.electricBlue,
                  length: 32.0,
                  strokeWidth: 2.0,
                ),
                child: Container(),
              ),
            ),
          ),

          // 3. UI Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close Button
                      Container(
                        margin: const EdgeInsets.only(top: 4, left: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(LucideIcons.x, color: Colors.white, size: 24),
                          onPressed: () => context.go('/dashboard'),
                        ),
                      ),
                      
                      // Heart Rate Indicator
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.biometricRed.withOpacity(0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.biometricRed.withOpacity(0.3),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.heart,
                              color: AppColors.biometricRed,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '66 BPM',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Center Content
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.electricBlue.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.electricBlue.withOpacity(0.1),
                              blurRadius: 32,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.electricBlue.withOpacity(0.05),
                          ),
                          child: const Icon(
                            LucideIcons.camera,
                            color: AppColors.electricBlue,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Camera activates when you start',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  // Bottom Content
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Record Button
                      GestureDetector(
                        onTap: () => context.go('/active_workout'),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.electricBlue.withOpacity(0.15),
                            border: Border.all(
                              color: AppColors.electricBlue.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.electricBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.electricBlue.withOpacity(0.5),
                                  blurRadius: 16,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Exercise Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.electricBlue.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.activity,
                              color: AppColors.electricBlue,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Squat Exercise',
                              style: TextStyle(
                                color: AppColors.electricBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              LucideIcons.zap,
                              color: AppColors.neonGreen,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CornerBracketsPainter extends CustomPainter {
  final Color color;
  final double length;
  final double strokeWidth;

  CornerBracketsPainter({
    required this.color,
    this.length = 24.0,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Top-Left
    canvas.drawPath(
      Path()
        ..moveTo(0, length)
        ..lineTo(0, 0)
        ..lineTo(length, 0),
      paint,
    );
    // Top-Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - length, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, length),
      paint,
    );
    // Bottom-Left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - length)
        ..lineTo(0, size.height)
        ..lineTo(length, size.height),
      paint,
    );
    // Bottom-Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width, size.height - length)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width - length, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03) // Very faint grid
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trainer/theme/app_colors.dart';
import 'package:smart_trainer/screens/training_screen.dart'; // To reuse painters

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Grid
          CustomPaint(
            size: Size.infinite,
            painter: GridPainter(),
          ),

          // Corner Brackets Layer
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

          // UI Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row
                  Column(
                    children: [
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
                                  '68 BPM',
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
                      const SizedBox(height: 32),
                      
                      // Stats Row (Time, Reps, Accuracy)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatBox('TIME', '00:01', Colors.white),
                          const SizedBox(width: 16),
                          _buildStatBox('REPS', '0', AppColors.electricBlue),
                          const SizedBox(width: 16),
                          _buildStatBox('ACCURACY', '0%', AppColors.neonGreen),
                        ],
                      ),
                    ],
                  ),

                  // Center Message
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.biometricRed.withOpacity(0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.biometricRed.withOpacity(0.15),
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.alertCircle, color: AppColors.biometricRed, size: 24),
                        const SizedBox(width: 12),
                        const Text(
                          'Get ready...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Content
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Stop & View Results Button
                      SizedBox(
                        width: 280,
                        child: ElevatedButton(
                          onPressed: () => context.go('/workout_result'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.biometricRed,
                            shadowColor: AppColors.biometricRed.withOpacity(0.5),
                            elevation: 16,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Stop & View Results',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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

  Widget _buildStatBox(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.8),
              fontSize: 10,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

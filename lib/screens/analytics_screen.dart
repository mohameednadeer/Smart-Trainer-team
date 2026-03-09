import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trainer/theme/app_colors.dart';
import 'package:smart_trainer/widgets/glass_container.dart';
import 'package:smart_trainer/widgets/neon_button.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.go('/training'),
        ),
        title: const Text(
          'Workout Summary',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Accuracy Ring
            GlassContainer(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const Icon(LucideIcons.trophy, color: AppColors.electricBlue, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'EXCELLENT FORM',
                    style: TextStyle(
                      color: AppColors.neonGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        PieChart(
                          PieChartData(
                            startDegreeOffset: 270,
                            sectionsSpace: 0,
                            centerSpaceRadius: 70,
                            sections: [
                              PieChartSectionData(
                                color: AppColors.electricBlue,
                                value: 92,
                                title: '',
                                radius: 16,
                              ),
                              PieChartSectionData(
                                color: AppColors.surface,
                                value: 8,
                                title: '',
                                radius: 16,
                              ),
                            ],
                          ),
                        ),
                        const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '92%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Accuracy',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Feedback Cards
            const Text(
              'AI FEEDBACK',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeedbackCard(
              icon: LucideIcons.checkCircle2,
              iconColor: AppColors.neonGreen,
              title: 'Great Squat Depth',
              description: 'You consistently hit below parallel on 12/15 reps.',
            ),
            const SizedBox(height: 12),
            _buildFeedbackCard(
              icon: LucideIcons.alertTriangle,
              iconColor: AppColors.electricBlue,
              title: 'Knee Tracking',
              description: 'Your knees caved slightly inward on the last 3 reps. Focus on pushing them out.',
            ),
            const SizedBox(height: 24),

            // Performance / Heart Rate Chart
            const Text(
              'HEART RATE INTENSITY',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            GlassContainer(
              height: 200,
              padding: const EdgeInsets.only(right: 24, left: 16, top: 24, bottom: 16),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: _bottomTitleWidgets,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 80,
                  maxY: 160,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 85),
                        FlSpot(1, 110),
                        FlSpot(2, 125),
                        FlSpot(3, 135),
                        FlSpot(4, 142),
                        FlSpot(5, 138),
                        FlSpot(6, 115),
                      ],
                      isCurved: true,
                      color: AppColors.biometricRed,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.biometricRed.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            NeonButton(
              text: 'Save Workout',
              icon: LucideIcons.save,
              onPressed: () => context.go('/auth'),
            ),
            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  String text;
  switch (value.toInt()) {
    case 80:
      text = '80';
      break;
    case 120:
      text = '120';
      break;
    case 160:
      text = '160';
      break;
    default:
      return Container();
  }
  return Text(text, style: style, textAlign: TextAlign.right);
}


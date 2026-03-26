import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smart_trainer/theme/app_colors.dart';
import 'package:smart_trainer/theme/theme_ext.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _openIndex;

  final List<Map<String, String>> _faqs = [
    {
      'q': 'How does the AI pose detection work?',
      'a':
          'Smart Trainer uses MoveNet Lightning, a real-time pose estimation model by Google. It analyzes your body position through the camera and tracks 17 key body landmarks to evaluate your exercise form. All processing happens on-device — no data is sent to the internet.',
    },
    {
      'q': 'Why is my workout session not detecting my movements?',
      'a':
          'Make sure you are fully visible in the camera frame standing 1–2 meters away. Ensure good lighting and wear form-fitting clothes so your body outline is clear. The camera should be positioned at a steady height.',
    },
    {
      'q': 'How do I connect my heart rate sensor?',
      'a':
          'Go to Settings → Connect Bluetooth Sensor, and make sure your MAX30102 sensor is powered on and in range. The app will automatically detect and pair with the device.',
    },
    {
      'q': 'Can I use Smart Trainer without a Bluetooth sensor?',
      'a':
          'Yes! The Bluetooth sensor is optional. You can do complete workouts with pose tracking and rep counting using just your phone camera. The heart rate monitor is only used for BPM display.',
    },
    {
      'q': 'How is my accuracy score calculated?',
      'a':
          'The accuracy score is determined by how closely your joint angles match the ideal target angles for the exercise being performed. For example, for squats, it checks knee bend, spine alignment, and hip depth.',
    },
    {
      'q': 'Is my data stored in the cloud?',
      'a':
          'Most data is stored locally on your device. Visit Privacy & Security in Settings for full details on how we handle your data.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.electricBlue),
          onPressed: () => context.pop(),
        ),
        title: Text('Help & Support',
            style: TextStyle(color: context.textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Contact banner
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.electricBlue, AppColors.electricBlue.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.mail, color: Colors.white, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Contact Support',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('support@smarttrainer.app',
                          style: TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Text('Frequently Asked Questions',
              style: TextStyle(
                  color: context.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // FAQ Accordion
          ...List.generate(_faqs.length, (i) {
            final isOpen = _openIndex == i;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isOpen
                        ? AppColors.electricBlue.withOpacity(0.4)
                        : context.glassBorderColor),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _openIndex = isOpen ? null : i),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(_faqs[i]['q']!,
                                style: TextStyle(
                                    color: context.textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Icon(
                            isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                            color: AppColors.electricBlue,
                            size: 20,
                          ),
                        ],
                      ),
                      if (isOpen) ...[
                        const SizedBox(height: 12),
                        Text(_faqs[i]['a']!,
                            style: TextStyle(
                                color: context.secondaryTextColor,
                                fontSize: 14,
                                height: 1.6)),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Center(
            child: Text('Smart Trainer v1.0.0 • Made with ❤️',
                style:
                    TextStyle(color: context.secondaryTextColor, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

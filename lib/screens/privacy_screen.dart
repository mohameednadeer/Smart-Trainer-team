import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smart_trainer/theme/app_colors.dart';
import 'package:smart_trainer/theme/theme_ext.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

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
        title: Text('Privacy & Security',
            style: TextStyle(color: context.textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSection(
            context,
            icon: LucideIcons.lock,
            title: 'Data Encryption',
            body:
                'All your workout data and personal information are encrypted using AES-256 encryption both in transit and at rest. Your data is completely secure.',
          ),
          _buildSection(
            context,
            icon: LucideIcons.eye,
            title: 'Camera Privacy',
            body:
                'The camera is only used during active workout sessions to analyze your movements in real-time using on-device AI. No video is recorded or sent to any server.',
          ),
          _buildSection(
            context,
            icon: LucideIcons.bluetooth,
            title: 'Bluetooth Sensor Data',
            body:
                'Heart rate data collected from your Bluetooth sensor is stored locally on your device. You can delete it at any time from your profile settings.',
          ),
          _buildSection(
            context,
            icon: LucideIcons.server,
            title: 'Data Storage',
            body:
                'Smart Trainer stores most data locally on your device. Only essential account data is synced to our secure servers. You can request data deletion at any time by contacting support.',
          ),
          _buildSection(
            context,
            icon: LucideIcons.userX,
            title: 'Delete Your Account',
            body:
                'You can permanently delete your account and all associated data by contacting our support team at support@smarttrainer.app. Account deletion is processed within 72 hours.',
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Last updated: January 2026 • Smart Trainer v1.0.0',
              style: TextStyle(color: context.secondaryTextColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required IconData icon, required String title, required String body}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.glassBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.electricBlue.withOpacity(0.1),
                ),
                child: Icon(icon, color: AppColors.electricBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Text(title,
                  style: TextStyle(
                      color: context.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(body,
              style: TextStyle(
                  color: context.secondaryTextColor,
                  fontSize: 14,
                  height: 1.6)),
        ],
      ),
    );
  }
}

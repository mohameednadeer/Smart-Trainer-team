import 'package:flutter/material.dart';
import 'package:smart_trainer/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PulseBadge extends StatefulWidget {
  final int bpm;

  const PulseBadge({super.key, required this.bpm});

  @override
  State<PulseBadge> createState() => _PulseBadgeState();
}

class _PulseBadgeState extends State<PulseBadge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.biometricRed.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.biometricRed.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _animation,
            child: const Icon(
              LucideIcons.heart,
              color: AppColors.biometricRed,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${widget.bpm} BPM',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

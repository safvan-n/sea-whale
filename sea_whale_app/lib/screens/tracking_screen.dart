import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class TrackingScreen extends StatefulWidget {
  final String orderId;

  const TrackingScreen({super.key, this.orderId = 'SW-984210'});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  double _temperature = 1.4;
  Timer? _telemetryTimer;

  @override
  void initState() {
    super.initState();
    // Simulate minor live temperature fluctuations between 0.8C and 1.8C
    _telemetryTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _temperature = 1.0 + Random().nextDouble() * 0.7;
        });
      }
    });
  }

  @override
  void dispose() {
    _telemetryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text(
          'Cold Chain Live Telemetry',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.oceanWhite,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Order ID & Status Header Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0E244D), Color(0xFF0F1A34)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CONTAINER ${widget.orderId}',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.accentCyan,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppTheme.successGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'LIVE SENSORS',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.successGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Large Temperature Dial
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBgElevated,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppTheme.accentCyan.withAlpha(120),
                            width: 2),
                      ),
                      child: const Icon(
                        Icons.ac_unit_rounded,
                        color: AppTheme.accentCyan,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_temperature.toStringAsFixed(1)}°C',
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.oceanWhite,
                          ),
                        ),
                        Text(
                          'Sub-Zero Cryo Guard: Optimal (0°C to 2°C)',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.lightCyan,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                const Divider(color: AppTheme.borderLight),
                const SizedBox(height: 8),

                // Telemetry metrics row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMetric('Insulation', '100% Locked'),
                    _buildMetric('Nitrogen Level', 'Optimal 98%'),
                    _buildMetric('Transit ETA', '24 Mins'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Route & Dock Milestone Timeline
          Text(
            'Cold Chain Dispatch Timeline',
            style: GoogleFonts.outfit(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 14),

          _buildTimelineStep(
            title: 'Harbour Dock Catch Arrived',
            subtitle: 'Kochi Deep Sea Jetty Dock #4 - Inspected by marine quality team',
            time: '08:15 AM',
            isCompleted: true,
          ),
          _buildTimelineStep(
            title: 'Cryogenic Sub-Zero Packaging',
            subtitle: 'Nitrogen-flushed insulated dry boxes sealed with temp logger #TG-88',
            time: '08:45 AM',
            isCompleted: true,
          ),
          _buildTimelineStep(
            title: 'Refrigerated Fleet Dispatched',
            subtitle: 'Sea Whale Transport Chilled Reefer Van #KL-07-SW-900 en route',
            time: '09:20 AM',
            isCompleted: true,
            isCurrent: true,
          ),
          _buildTimelineStep(
            title: 'Express Doorstep Delivery',
            subtitle: 'Recipient hand-over under thermal insulation bag',
            time: 'ETA 09:45 AM',
            isCompleted: false,
          ),

          const SizedBox(height: 24),

          // Cold-chain logistics vehicle card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logistics.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sea Whale Chilled Logistics',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Fleet Driver: Rajesh Kumar (Reefer Certified)',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 13, color: AppTheme.accentCyan),
                          const SizedBox(width: 4),
                          Text(
                            '+91 98470 12345',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppTheme.accentCyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String val) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.oceanWhite,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required String time,
    required bool isCompleted,
    bool isCurrent = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isCompleted
                    ? (isCurrent ? AppTheme.accentCyan : AppTheme.primaryTeal)
                    : AppTheme.cardBgElevated,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppTheme.lightCyan : AppTheme.textMuted,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            Container(
              width: 2,
              height: 50,
              color: isCompleted ? AppTheme.primaryTeal : AppTheme.borderLight,
            ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? AppTheme.oceanWhite
                            : AppTheme.textMuted,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

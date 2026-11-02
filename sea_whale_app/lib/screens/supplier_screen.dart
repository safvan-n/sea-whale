import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  final TextEditingController _boatNameCtrl =
      TextEditingController(text: 'Matsya Kanya Trawler #KL-07-284');
  final TextEditingController _weightCtrl =
      TextEditingController(text: '350');
  final TextEditingController _payoutRateCtrl =
      TextEditingController(text: '420');

  String _harbourPort = 'Kochi Deep Sea Fisheries Harbour (Pier 3)';
  String _selectedCatch = 'Yellowfin Tuna (Deep Sea Catch)';
  String _chillingStatus = 'Ice Bed Chilled (-1°C on Board)';
  bool _chemicalFreeConfirmed = true;

  final List<Map<String, dynamic>> _mySupplies = [
    {
      'batchId': 'BATCH-SW-8812',
      'item': 'Jumbo Black Tiger Prawns',
      'weight': '480 kg',
      'port': 'Kochi Harbour Pier 2',
      'status': 'Quality Approved & Chilled',
      'payout': '₹3,36,000',
      'statusColor': AppTheme.successGreen,
      'date': 'Today, 06:30 AM',
    },
    {
      'batchId': 'BATCH-SW-8790',
      'item': 'Atlantic Salmon Flown Lot',
      'weight': '250 kg',
      'port': 'Cochin Airport Cargo Dock',
      'status': 'In Sub-Zero Transit',
      'payout': '₹2,75,000',
      'statusColor': AppTheme.accentCyan,
      'date': 'Yesterday',
    },
    {
      'batchId': 'BATCH-SW-8640',
      'item': 'Gourmet Live Mud Crabs',
      'weight': '180 Units',
      'port': 'Munambam Coastal Estuary',
      'status': 'Payment Settled',
      'payout': '₹1,98,000',
      'statusColor': AppTheme.goldAccent,
      'date': '30 Oct 2026',
    },
  ];

  @override
  void dispose() {
    _boatNameCtrl.dispose();
    _weightCtrl.dispose();
    _payoutRateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weight = double.tryParse(_weightCtrl.text) ?? 0.0;
    final rate = double.tryParse(_payoutRateCtrl.text) ?? 0.0;
    final totalEstimate = (weight * rate).round();

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text(
          'Supplier & Dock Partner Portal',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.oceanWhite,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Supplier Profile Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F2B48), Color(0xFF0B172E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.accentCyan.withAlpha(80)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(80),
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.accentCyan.withAlpha(35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.sailing_rounded,
                              color: AppTheme.accentCyan, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Malabar Sea Catch Co-op',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.oceanWhite,
                              ),
                            ),
                            Text(
                              'Verified Partner ID: #SW-SUP-410',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.lightCyan,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ACTIVE VENDOR',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.successGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppTheme.borderLight),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Total Supplied', '4.8 Tons'),
                    _buildStat('Active Batches', '2 Lots'),
                    _buildStat('Pending Payout', '₹2,48,500'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Register New Catch Haul Form Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Register Incoming Catch',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.oceanWhite,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.cardBgElevated,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Quick Dock Entry',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Form Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trawler name
                Text(
                  'Trawler / Boat Name & Reg. No.',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.oceanWhite,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _boatNameCtrl,
                  style: GoogleFonts.inter(
                      color: AppTheme.oceanWhite, fontSize: 13),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.directions_boat_outlined,
                        size: 18, color: AppTheme.accentCyan),
                    filled: true,
                    fillColor: AppTheme.cardBgElevated,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Species / Commodity
                Text(
                  'Catch Category & Species',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.oceanWhite,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBgElevated,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCatch,
                      dropdownColor: AppTheme.cardBgElevated,
                      isExpanded: true,
                      style: GoogleFonts.inter(
                          color: AppTheme.oceanWhite, fontSize: 13),
                      items: [
                        'Yellowfin Tuna (Deep Sea Catch)',
                        'Jumbo Black Tiger Prawns (Grade A1)',
                        'Gourmet Live Mud Crabs',
                        'Atlantic Salmon Portions',
                        'Coastal Squid / Calamari',
                        'Seer Fish / King Fish Whole',
                      ]
                          .map((item) => DropdownMenuItem(
                              value: item, child: Text(item)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedCatch = v!),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Docking Location
                Text(
                  'Docking Pier & Terminal',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.oceanWhite,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBgElevated,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _harbourPort,
                      dropdownColor: AppTheme.cardBgElevated,
                      isExpanded: true,
                      style: GoogleFonts.inter(
                          color: AppTheme.oceanWhite, fontSize: 13),
                      items: [
                        'Kochi Deep Sea Fisheries Harbour (Pier 3)',
                        'Vizhinjam International Mother Port',
                        'Munambam Marine Catch Terminal',
                        'Beypore Coastal Harbour, Kozhikode',
                      ]
                          .map((port) => DropdownMenuItem(
                              value: port, child: Text(port)))
                          .toList(),
                      onChanged: (v) => setState(() => _harbourPort = v!),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Weight & Rate Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated KG',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.oceanWhite,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _weightCtrl,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            style: GoogleFonts.inter(
                                color: AppTheme.oceanWhite, fontSize: 13),
                            decoration: InputDecoration(
                              suffixText: 'KG',
                              suffixStyle: GoogleFonts.inter(
                                  color: AppTheme.accentCyan,
                                  fontWeight: FontWeight.w700),
                              filled: true,
                              fillColor: AppTheme.cardBgElevated,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wholesale Rate/KG',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.oceanWhite,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _payoutRateCtrl,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            style: GoogleFonts.inter(
                                color: AppTheme.oceanWhite, fontSize: 13),
                            decoration: InputDecoration(
                              prefixText: '₹ ',
                              prefixStyle: GoogleFonts.inter(
                                  color: AppTheme.accentCyan,
                                  fontWeight: FontWeight.w700),
                              filled: true,
                              fillColor: AppTheme.cardBgElevated,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Cold chain onboard status
                Text(
                  'Onboard Cold Chain Preservation',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.oceanWhite,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBgElevated,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _chillingStatus,
                      dropdownColor: AppTheme.cardBgElevated,
                      isExpanded: true,
                      style: GoogleFonts.inter(
                          color: AppTheme.oceanWhite, fontSize: 13),
                      items: [
                        'Ice Bed Chilled (-1°C on Board)',
                        'Sub-Zero Cryo Freezing (-18°C Sealed)',
                        'Live Sea-Water Aerated Tankers',
                      ]
                          .map((val) => DropdownMenuItem(
                              value: val, child: Text(val)))
                          .toList(),
                      onChanged: (v) => setState(() => _chillingStatus = v!),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Formalin / Chemical Free Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _chemicalFreeConfirmed,
                      activeColor: AppTheme.accentCyan,
                      checkColor: AppTheme.darkBg,
                      onChanged: (val) =>
                          setState(() => _chemicalFreeConfirmed = val ?? true),
                    ),
                    Expanded(
                      child: Text(
                        'I certify 100% Formalin & Ammonia Free, lab compliant catch.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.lightCyan,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Calculated settlement banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.accentCyan.withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: AppTheme.accentCyan.withAlpha(60)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estimated Lot Settlement:',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      Text(
                        '₹${totalEstimate.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: GoogleFonts.outfit(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.accentCyan,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final newBatch = {
                        'batchId':
                            'BATCH-SW-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                        'item': _selectedCatch,
                        'weight': '${weight.toInt()} kg',
                        'port': _harbourPort.split('(').first.trim(),
                        'status': 'Pending Dock Inspection',
                        'payout': '₹${totalEstimate.toInt()}',
                        'statusColor': AppTheme.accentCyan,
                        'date': 'Just now',
                      };

                      setState(() {
                        _mySupplies.insert(0, newBatch);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppTheme.cardBgElevated,
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: AppTheme.accentCyan, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Lot registered! Dock team dispatched to pier for cold inspection.',
                                  style: GoogleFonts.inter(
                                      color: AppTheme.oceanWhite),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                    label: const Text('SUBMIT CATCH FOR DOCK PICKUP'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Previous Supplies / Active Lots
          Text(
            'My Registered Supply Lots',
            style: GoogleFonts.outfit(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 12),

          ..._mySupplies.map((lot) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lot['batchId'],
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.accentCyan,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: (lot['statusColor'] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          lot['status'],
                          style: GoogleFonts.outfit(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: lot['statusColor'],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    lot['item'],
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.oceanWhite,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${lot['weight']} • ${lot['port']} • ${lot['date']}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  const Divider(color: AppTheme.borderLight, height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Direct Account Payout:',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      Text(
                        lot['payout'],
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
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
}

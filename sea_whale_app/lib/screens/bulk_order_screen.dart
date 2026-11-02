import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class BulkOrderScreen extends StatefulWidget {
  const BulkOrderScreen({super.key});

  @override
  State<BulkOrderScreen> createState() => _BulkOrderScreenState();
}

class _BulkOrderScreenState extends State<BulkOrderScreen> {
  final TextEditingController _businessNameCtrl = TextEditingController();
  final TextEditingController _contactCtrl = TextEditingController();
  String _selectedCategory = 'Seafood & Fish Tonnage';
  double _volumeTons = 1.0;
  String _chillingMode = 'Sub-Zero Nitrogen Reefer (-18°C)';

  @override
  void dispose() {
    _businessNameCtrl.dispose();
    _contactCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic wholesale estimate calculation
    final estimatedAmount = (_volumeTons * 1000 * 480).round();

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text(
          'B2B Wholesale & Cold Chain',
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
          // Header Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF142C54), Color(0xFF0B1933)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.business_center_rounded,
                        color: AppTheme.accentCyan, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Commercial Cold Chain Supply',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.oceanWhite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Supplying 5-star hotels, gourmet restaurant chains, and export hubs across India with refrigerated container fleets.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Business Details
          Text(
            'Company / Business Name',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _businessNameCtrl,
            style: GoogleFonts.inter(color: AppTheme.oceanWhite),
            decoration: InputDecoration(
              hintText: 'e.g. Grand Hyatt Cochin or Oceanic Seafoods',
              hintStyle:
                  GoogleFonts.inter(color: AppTheme.textMuted, fontSize: 13),
              filled: true,
              fillColor: AppTheme.cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.borderLight),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Contact
          Text(
            'Procurement Manager Contact',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contactCtrl,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.inter(color: AppTheme.oceanWhite),
            decoration: InputDecoration(
              hintText: '+91 98950 00000',
              hintStyle:
                  GoogleFonts.inter(color: AppTheme.textMuted, fontSize: 13),
              filled: true,
              fillColor: AppTheme.cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.borderLight),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Commodity Category
          Text(
            'Supply Commodity Category',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                dropdownColor: AppTheme.cardBgElevated,
                isExpanded: true,
                style: GoogleFonts.outfit(
                    color: AppTheme.oceanWhite, fontSize: 14),
                items: [
                  'Seafood & Fish Tonnage',
                  'Tiger Prawns Export Crates',
                  'Cold-Chain Poultry & Chicken',
                  'Mountain Mutton Chilled Halves',
                  'Imported Wagyu Steaks Bulk',
                ]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Chilling Logistics Mode
          Text(
            'Cold Chain Transit Mode',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _chillingMode,
                dropdownColor: AppTheme.cardBgElevated,
                isExpanded: true,
                style: GoogleFonts.outfit(
                    color: AppTheme.oceanWhite, fontSize: 14),
                items: [
                  'Sub-Zero Nitrogen Reefer (-18°C)',
                  'Chilled Air Transport (0°C to 2°C)',
                  'Live Vessel Aquarium Tankers',
                ]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _chillingMode = val!),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Volume Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated Monthly Volume',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.oceanWhite,
                ),
              ),
              Text(
                '${_volumeTons.toStringAsFixed(1)} Tons (${(_volumeTons * 1000).toInt()} KG)',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.accentCyan,
                ),
              ),
            ],
          ),
          Slider(
            value: _volumeTons,
            min: 0.5,
            max: 20.0,
            divisions: 39,
            activeColor: AppTheme.accentCyan,
            inactiveColor: AppTheme.cardBgElevated,
            onChanged: (v) => setState(() => _volumeTons = v),
          ),

          const SizedBox(height: 16),

          // Estimated B2B Quote Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBgElevated,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.accentCyan.withAlpha(80)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wholesale Volume Indicative Quote',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.lightCyan,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Est. Base Contract Value:',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    Text(
                      '₹${estimatedAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.oceanWhite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Includes GPS Temp-Monitored Reefer Van Delivery & Insurance',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppTheme.cardBg,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  title: Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: AppTheme.accentCyan),
                      const SizedBox(width: 8),
                      Text('Quotation Requested',
                          style: GoogleFonts.outfit(
                              color: AppTheme.oceanWhite, fontSize: 18)),
                    ],
                  ),
                  content: Text(
                    'Thank you. Our B2B Corporate Supply team will review your ${_volumeTons.toStringAsFixed(1)} Ton requirement and dispatch the SLA & contract pricing directly to your contact number.',
                    style: GoogleFonts.inter(
                        color: AppTheme.textMuted, fontSize: 13),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('DONE'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.description_outlined, size: 18),
            label: const Text('REQUEST FORMAL WHOLESALE CONTRACT'),
          ),
        ],
      ),
    );
  }
}

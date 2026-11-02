import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PreOrderScreen extends StatefulWidget {
  const PreOrderScreen({super.key});

  @override
  State<PreOrderScreen> createState() => _PreOrderScreenState();
}

class _PreOrderScreenState extends State<PreOrderScreen> {
  String _selectedCatch = 'King Red Lobster (Live)';
  String _selectedPort = 'Kochi Fisheries Harbour Pier #2';
  String _cuttingStyle = 'Steaks & Fillets';
  double _requestedKg = 5.0;

  final List<String> _catches = [
    'King Red Lobster (Live)',
    'Yellowfin Bluefin Tuna Whole',
    'Norwegian Cold-Water Cod',
    'Giant Tiger Prawns (Grade A1)',
    'Alaskan King Crab Clusters',
  ];

  final List<String> _ports = [
    'Kochi Fisheries Harbour Pier #2',
    'Vizhinjam Deep Sea Mother Port',
    'Munambam Marine Terminal',
    'Mangalore Sea Port Dock',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text(
          'Pre-Order Upcoming Catch',
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
          // Banner card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF005082), Color(0xFF002244)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.accentCyan,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'DOCK RESERVATION',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBg,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reserve Before Boats Dock',
                        style: GoogleFonts.outfit(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lock in rare deep-sea seafood directly from trawler nets at dockside wholesale prices.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.lightCyan,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/fresh_catch.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Catch Selection
          Text(
            'Select Marine Catch',
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
                value: _selectedCatch,
                dropdownColor: AppTheme.cardBgElevated,
                isExpanded: true,
                style: GoogleFonts.outfit(
                    color: AppTheme.oceanWhite, fontSize: 14),
                items: _catches
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCatch = val!),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Harbour Dock Port
          Text(
            'Arrival Harbour & Vessel Dock',
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
                value: _selectedPort,
                dropdownColor: AppTheme.cardBgElevated,
                isExpanded: true,
                style: GoogleFonts.outfit(
                    color: AppTheme.oceanWhite, fontSize: 14),
                items: _ports
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedPort = val!),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Quantity Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reserved Quantity',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.oceanWhite,
                ),
              ),
              Text(
                '${_requestedKg.toInt()} Kilograms',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.accentCyan,
                ),
              ),
            ],
          ),
          Slider(
            value: _requestedKg,
            min: 2,
            max: 50,
            divisions: 24,
            activeColor: AppTheme.accentCyan,
            inactiveColor: AppTheme.cardBgElevated,
            onChanged: (val) => setState(() => _requestedKg = val),
          ),

          const SizedBox(height: 14),

          // Cutting & Processing Style
          Text(
            'Custom Dock Preparation Style',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.oceanWhite,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              'Whole Cleaned',
              'Steaks & Fillets',
              'Curry Cut',
              'Sub-Zero Vacuum Sealed',
            ].map((style) {
              final isSelected = _cuttingStyle == style;
              return ChoiceChip(
                label: Text(style),
                selected: isSelected,
                selectedColor: AppTheme.accentCyan.withAlpha(40),
                backgroundColor: AppTheme.cardBg,
                labelStyle: GoogleFonts.inter(
                  fontSize: 12,
                  color: isSelected ? AppTheme.accentCyan : AppTheme.oceanWhite,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
                side: BorderSide(
                  color: isSelected ? AppTheme.accentCyan : AppTheme.borderLight,
                ),
                onSelected: (_) => setState(() => _cuttingStyle = style),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Submit Reservation
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
                      const Icon(Icons.anchor_rounded,
                          color: AppTheme.accentCyan),
                      const SizedBox(width: 8),
                      Text('Catch Reserved!',
                          style: GoogleFonts.outfit(
                              color: AppTheme.oceanWhite, fontSize: 18)),
                    ],
                  ),
                  content: Text(
                    'Your pre-order for ${_requestedKg.toInt()} kg of $_selectedCatch at $_selectedPort has been recorded. Our dock coordinator will alert you when vessel radar enters port.',
                    style: GoogleFonts.inter(
                        color: AppTheme.textMuted, fontSize: 13),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.send_rounded, size: 18),
            label: const Text('SUBMIT HARBOUR PRE-ORDER'),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'pre_order_screen.dart';
import 'bulk_order_screen.dart';
import 'tracking_screen.dart';
import 'supplier_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigateTab;
  final VoidCallback? onOpenDrawer;

  const HomeScreen({
    super.key,
    required this.onNavigateTab,
    this.onOpenDrawer,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _countdownTimer;
  Duration _timeLeft = const Duration(hours: 4, minutes: 22, seconds: 45);

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeLeft.inSeconds > 0) {
            _timeLeft = _timeLeft - const Duration(seconds: 1);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(d.inHours);
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: CustomScrollView(
        slivers: [
          // Luxury Top App Bar
          SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: AppTheme.darkBg,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu_rounded, color: AppTheme.oceanWhite),
              tooltip: 'Menu',
              onPressed: widget.onOpenDrawer,
            ),
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/logo.jpg',
                    width: 34,
                    height: 34,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEA WHALE',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.oceanWhite,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 11, color: AppTheme.accentCyan),
                        const SizedBox(width: 2),
                        Text(
                          'Kochi Harbour, Kerala',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.sailing_rounded,
                    color: AppTheme.accentCyan),
                tooltip: 'Supplier Portal',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SupplierScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.radar_rounded,
                    color: AppTheme.accentCyan),
                tooltip: 'Live Telemetry',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TrackingScreen()),
                  );
                },
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined,
                        color: AppTheme.oceanWhite),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (shop.cartCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.accentCyan,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${shop.cartCount}',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBg,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Main Home Feed
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Trigger Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InkWell(
                    onTap: () => widget.onNavigateTab(1),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.borderLight),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: AppTheme.accentCyan, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Search fresh salmon, prawns, steaks...',
                            style: GoogleFonts.inter(
                              color: AppTheme.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Hero Banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderLight),
                      image: const DecorationImage(
                        image: AssetImage('assets/hero_banner.png'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(80),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withAlpha(220),
                            Colors.black.withAlpha(140),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentCyan,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'COLD-CHAIN ASSURED',
                              style: GoogleFonts.outfit(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.darkBg,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Dock Fresh Catch\nFlown Under 0-2°C',
                            style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.oceanWhite,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Chemical-free fresh cuts delivered in 90 mins.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.lightCyan,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Flash Deal Countdown Strip
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2C1628), Color(0xFF161C38)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color(0xFFEF476F).withAlpha(80)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bolt,
                                color: Color(0xFFEF476F), size: 20),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FLASH DOCK DEAL: 20% OFF',
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Coupon: SEAWALE20 at checkout',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: AppTheme.textMuted,
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
                            color: Colors.black.withAlpha(120),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _formatDuration(_timeLeft),
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFEF476F),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Categories Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore Categories',
                        style: GoogleFonts.outfit(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      InkWell(
                        onTap: () => widget.onNavigateTab(1),
                        child: Text(
                          'View All',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.accentCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Categories Horizontal List
                SizedBox(
                  height: 94,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: shop.categories.length,
                    itemBuilder: (context, i) {
                      final c = shop.categories[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            shop.setCategory(c.id);
                            widget.onNavigateTab(1);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 78,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.borderLight),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: c.accentColor.withAlpha(35),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(c.icon,
                                      size: 20, color: c.accentColor),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  c.name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.oceanWhite,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Today's Catch Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flash_on_rounded,
                              color: AppTheme.accentCyan, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            "Today's Dock Catch",
                            style: GoogleFonts.outfit(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.oceanWhite,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '0-2°C Nitrogen Chilled',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Today's Catch Horizontal Cards
                SizedBox(
                  height: 310,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: shop.todayCatchProducts.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 14),
                    itemBuilder: (context, i) {
                      return SizedBox(
                        width: 200,
                        child:
                            ProductCard(product: shop.todayCatchProducts[i]),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Pre-Order & Bulk Order Banner Tiles
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Pre-order tile
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PreOrderScreen()),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0C2444),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color:
                                      AppTheme.accentCyan.withAlpha(100)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.anchor_rounded,
                                    color: AppTheme.accentCyan, size: 24),
                                const SizedBox(height: 8),
                                Text(
                                  'Pre-Order Catch',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.oceanWhite,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Book before boats dock',
                                  style: GoogleFonts.inter(
                                    fontSize: 10.5,
                                    color: AppTheme.lightCyan,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Bulk order tile
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const BulkOrderScreen()),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF221F38),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppTheme.goldAccent.withAlpha(100)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.inventory_2_outlined,
                                    color: AppTheme.goldAccent, size: 24),
                                const SizedBox(height: 8),
                                Text(
                                  'Bulk Logistics',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.oceanWhite,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'B2B Wholesale quotes',
                                  style: GoogleFonts.inter(
                                    fontSize: 10.5,
                                    color: AppTheme.goldAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Catch Supplier & Fisherman Portal Banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SupplierScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F2B48), Color(0xFF071B33)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppTheme.accentCyan.withAlpha(90)),
                      ),
                      child: Row(
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
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Catch Supplier & Dock Portal',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.oceanWhite,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppTheme.successGreen.withAlpha(30),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'PARTNER',
                                        style: GoogleFonts.outfit(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: AppTheme.successGreen,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Fishermen & boat owners: List incoming catches for direct dock settlement.',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 14, color: AppTheme.accentCyan),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Best Sellers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sea Whale Bestsellers',
                        style: GoogleFonts.outfit(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      InkWell(
                        onTap: () => widget.onNavigateTab(1),
                        child: Text(
                          'See Store',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.accentCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Bestsellers Grid (4 items)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: shop.bestSellerProducts.length,
                    itemBuilder: (context, i) {
                      return ProductCard(
                          product: shop.bestSellerProducts[i]);
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Quality Assurance cold-chain info cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Sea Whale Cold Chain Standard',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.oceanWhite,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildColdStep(
                          icon: Icons.water_drop_outlined,
                          title: 'Vessel Dock Harvest',
                          subtitle: 'Handpicked within 30 mins of net hauling.',
                        ),
                        _buildColdStep(
                          icon: Icons.ac_unit,
                          title: 'Sub-Zero Cryo Lock (-18°C / 0-2°C)',
                          subtitle:
                              'Continuous temperature maintained without thawing.',
                        ),
                        _buildColdStep(
                          icon: Icons.local_shipping_outlined,
                          title: 'Live GPS Temp Monitoring',
                          subtitle:
                              'Inspect cold-chain graphs on every order in real-time.',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColdStep({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.cardBgElevated,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: AppTheme.accentCyan),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.oceanWhite,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textMuted,
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

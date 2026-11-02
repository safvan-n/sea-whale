import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'products_screen.dart';
import 'pre_order_screen.dart';
import 'tracking_screen.dart';
import 'cart_screen.dart';
import 'supplier_screen.dart';
import 'bulk_order_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);

    final List<Widget> screens = [
      HomeScreen(onNavigateTab: _onTabSelected),
      const ProductsScreen(),
      const PreOrderScreen(),
      const TrackingScreen(),
      const CartScreen(),
    ];

    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppTheme.darkBg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F2B48), Color(0xFF071B33)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/logo.jpg',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'SEA WHALE TRANSPORT',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.oceanWhite,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'Sub-Zero Cold Chain & Dock Logistics',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.lightCyan,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: AppTheme.accentCyan),
              title: Text('Home',
                  style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.storefront_rounded,
                  color: AppTheme.accentCyan),
              title: Text('Store & Fresh Dock',
                  style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(1);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.anchor_rounded, color: AppTheme.accentCyan),
              title: Text('Pre-Order Catch',
                  style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(2);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.radar_rounded, color: AppTheme.accentCyan),
              title: Text('Live Cold-Chain Tracker',
                  style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(3);
              },
            ),
            const Divider(color: AppTheme.borderLight),
            ListTile(
              leading: const Icon(Icons.sailing_rounded,
                  color: AppTheme.accentCyan),
              title: Text('Supplier & Dock Partner Portal',
                  style: GoogleFonts.outfit(
                      color: AppTheme.accentCyan, fontWeight: FontWeight.w700)),
              subtitle: Text('Boat owners: Register catch & payouts',
                  style: GoogleFonts.inter(
                      color: AppTheme.textMuted, fontSize: 11)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupplierScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.business_center_rounded,
                  color: AppTheme.goldAccent),
              title: Text('B2B Bulk Wholesale',
                  style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
              subtitle: Text('Hotel & restaurant tonnage quotes',
                  style: GoogleFonts.inter(
                      color: AppTheme.textMuted, fontSize: 11)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BulkOrderScreen()),
                );
              },
            ),
            const Divider(color: AppTheme.borderLight),
            ListTile(
              leading: const Icon(Icons.support_agent_rounded,
                  color: AppTheme.textMuted),
              title: Text('24/7 Dock Cold-Chain Helpline',
                  style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
              subtitle: Text('+91 484 222 9988',
                  style: GoogleFonts.inter(
                      color: AppTheme.lightCyan, fontSize: 11)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF091226),
          border: const Border(
            top: BorderSide(color: AppTheme.borderLight, width: 0.8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(120),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_filled,
                  label: 'Home',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.storefront_rounded,
                  label: 'Store',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.anchor_rounded,
                  label: 'Pre-Order',
                  index: 2,
                ),
                _buildNavItem(
                  icon: Icons.radar_rounded,
                  label: 'Tracker',
                  index: 3,
                ),
                _buildNavItem(
                  icon: Icons.shopping_bag_rounded,
                  label: 'Cart',
                  index: 4,
                  badgeCount: shop.cartCount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    int badgeCount = 0,
  }) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => _onTabSelected(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentCyan.withAlpha(25)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? AppTheme.accentCyan : AppTheme.textMuted,
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppTheme.accentCyan,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: GoogleFonts.outfit(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.darkBg,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppTheme.accentCyan : AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

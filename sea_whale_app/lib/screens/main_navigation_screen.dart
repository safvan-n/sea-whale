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

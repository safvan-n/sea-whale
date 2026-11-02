import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'featured';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);
    var products = shop.filteredProducts;

    // Apply sorting
    if (_sortBy == 'price_low') {
      products.sort((a, b) => a.discountedPrice.compareTo(b.discountedPrice));
    } else if (_sortBy == 'price_high') {
      products.sort((a, b) => b.discountedPrice.compareTo(a.discountedPrice));
    } else if (_sortBy == 'discount') {
      products.sort((a, b) => b.discountPercent.compareTo(a.discountPercent));
    }

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text(
          'Storefront & Fresh Dock',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.oceanWhite,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined,
                    color: AppTheme.oceanWhite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
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
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => shop.setSearchQuery(v),
                    style: GoogleFonts.inter(
                        color: AppTheme.oceanWhite, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Search Salmon, Tiger Prawns, Wagyu...',
                      hintStyle: GoogleFonts.inter(
                          color: AppTheme.textMuted, fontSize: 12),
                      prefixIcon: const Icon(Icons.search,
                          color: AppTheme.textMuted, size: 20),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close,
                                  color: AppTheme.textMuted, size: 16),
                              onPressed: () {
                                _searchController.clear();
                                shop.setSearchQuery('');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppTheme.cardBg,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppTheme.borderLight),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Sort Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _sortBy,
                      dropdownColor: AppTheme.cardBgElevated,
                      icon: const Icon(Icons.sort_rounded,
                          color: AppTheme.accentCyan, size: 20),
                      style: GoogleFonts.outfit(
                          fontSize: 12, color: AppTheme.oceanWhite),
                      items: const [
                        DropdownMenuItem(
                            value: 'featured', child: Text('Featured')),
                        DropdownMenuItem(
                            value: 'price_low', child: Text('Price: Low')),
                        DropdownMenuItem(
                            value: 'price_high', child: Text('Price: High')),
                        DropdownMenuItem(
                            value: 'discount', child: Text('Top Offers')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _sortBy = val);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Categories Filter Tabs
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryTab(
                  label: 'All Items',
                  id: 'all',
                  icon: Icons.all_inclusive,
                  shop: shop,
                ),
                ...shop.categories.map((c) => _buildCategoryTab(
                      label: c.name,
                      id: c.id,
                      icon: c.icon,
                      shop: shop,
                    )),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Product Grid
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off_rounded,
                            size: 60, color: AppTheme.textMuted),
                        const SizedBox(height: 12),
                        Text(
                          'No Marine Catch Found',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.oceanWhite,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Try clearing your search or switching categories',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      return ProductCard(product: products[i]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab({
    required String label,
    required String id,
    required IconData icon,
    required ShopProvider shop,
  }) {
    final isSelected = shop.selectedCategory == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => shop.setCategory(id),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.accentCyan
                : AppTheme.cardBgElevated,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppTheme.accentCyan : AppTheme.borderLight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? AppTheme.darkBg : AppTheme.oceanWhite,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                  color: isSelected ? AppTheme.darkBg : AppTheme.oceanWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

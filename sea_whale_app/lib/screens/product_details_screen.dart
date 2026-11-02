import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/shop_provider.dart';
import '../theme/app_theme.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _activeImageIndex = 0;
  late String _selectedWeight;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedWeight = widget.product.weights.first;
  }

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);
    final isFav = shop.isFavorite(widget.product.id);
    final unitPrice = widget.product.priceForWeight(_selectedWeight);
    final totalPrice = unitPrice * _quantity;

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: CustomScrollView(
        slivers: [
          // Luxury App Bar with Image Carousel
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: AppTheme.darkBg,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppTheme.darkBg.withAlpha(190),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 18, color: AppTheme.oceanWhite),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppTheme.darkBg.withAlpha(190),
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav
                          ? const Color(0xFFEF476F)
                          : AppTheme.oceanWhite,
                      size: 20,
                    ),
                    onPressed: () => shop.toggleFavorite(widget.product.id),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 8, bottom: 8),
                child: CircleAvatar(
                  backgroundColor: AppTheme.darkBg.withAlpha(190),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: AppTheme.oceanWhite, size: 20),
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
                          right: 4,
                          top: 4,
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
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    itemCount: widget.product.images.length,
                    onPageChanged: (i) => setState(() => _activeImageIndex = i),
                    itemBuilder: (context, i) {
                      return Image.asset(
                        widget.product.images[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: AppTheme.cardBgElevated,
                          child: const Icon(Icons.image,
                              size: 80, color: AppTheme.textMuted),
                        ),
                      );
                    },
                  ),
                  // Gradient shadow
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(90),
                            Colors.transparent,
                            AppTheme.darkBg,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Page Indicator Dots
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _activeImageIndex == index ? 22 : 8,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _activeImageIndex == index
                                ? AppTheme.accentCyan
                                : AppTheme.oceanWhite.withAlpha(80),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product Details Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.accentCyan.withAlpha(35),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppTheme.accentCyan.withAlpha(80)),
                        ),
                        child: Text(
                          widget.product.categoryName.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accentCyan,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: AppTheme.goldAccent, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.product.rating}',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: AppTheme.oceanWhite,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${widget.product.reviewCount}+ reviews)',
                            style: GoogleFonts.inter(
                              color: AppTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    widget.product.name,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.oceanWhite,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Freshness banner
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBgElevated,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.accentCyan.withAlpha(35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.ac_unit,
                              color: AppTheme.accentCyan, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Freshness Level: ${widget.product.freshness}',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppTheme.oceanWhite,
                                ),
                              ),
                              Text(
                                'Storage: ${widget.product.storageTemp} • Origin: ${widget.product.origin}',
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
                  ),

                  const SizedBox(height: 20),

                  // Weight Selection
                  Text(
                    'Select Weight / Pack Size',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.oceanWhite,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.product.weights.map((w) {
                      final isSelected = w == _selectedWeight;
                      final price = widget.product.priceForWeight(w);
                      return InkWell(
                        onTap: () => setState(() => _selectedWeight = w),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.accentCyan.withAlpha(35)
                                : AppTheme.cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.accentCyan
                                  : AppTheme.borderLight,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                w,
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppTheme.accentCyan
                                      : AppTheme.oceanWhite,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₹${price.toInt()}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.cardBgElevated,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.borderLight),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                              color: AppTheme.oceanWhite,
                            ),
                            Text(
                              '$_quantity',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.oceanWhite,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () => setState(() => _quantity++),
                              color: AppTheme.accentCyan,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'About this Catch',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.oceanWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Cold-Chain Quality Guarantees
                  Text(
                    'Sea Whale Transport Quality Promise',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.oceanWhite,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildGuaranteeItem(
                    icon: Icons.speed_rounded,
                    title: '90-Minute Express Delivery',
                    subtitle: 'Sealed cold insulated bags dispatched from dock.',
                  ),
                  _buildGuaranteeItem(
                    icon: Icons.verified_user_rounded,
                    title: 'Zero Chemical & Formalin Free',
                    subtitle: '100% natural catch with laboratory safety testing.',
                  ),
                  _buildGuaranteeItem(
                    icon: Icons.airline_stops_rounded,
                    title: 'Live GPS Temp Monitored',
                    subtitle: 'Sub-zero cryo-loggers tracking temperature in real-time.',
                  ),

                  const SizedBox(height: 90), // Bottom bar padding
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar with Pricing & Add to Cart
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(120),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
          border: const Border(
            top: BorderSide(color: AppTheme.borderLight, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  Text(
                    '₹${totalPrice.toInt()}',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.oceanWhite,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    shop.addToCart(
                      widget.product,
                      _selectedWeight,
                      quantity: _quantity,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppTheme.cardBgElevated,
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: AppTheme.accentCyan, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Added $_quantity x ${widget.product.name} to Cart',
                                style: GoogleFonts.inter(
                                    color: AppTheme.oceanWhite),
                              ),
                            ),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: 'VIEW CART',
                          textColor: AppTheme.accentCyan,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CartScreen()),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                  label: const Text('ADD TO CART'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuaranteeItem({
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
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Icon(icon, color: AppTheme.accentCyan, size: 18),
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

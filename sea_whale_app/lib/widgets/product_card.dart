import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/shop_provider.dart';
import '../theme/app_theme.dart';
import '../screens/product_details_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isHorizontal;

  const ProductCard({
    super.key,
    required this.product,
    this.isHorizontal = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late String _selectedWeight;

  @override
  void initState() {
    super.initState();
    _selectedWeight = widget.product.weights.first;
  }

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);
    final isFav = shop.isFavorite(widget.product.id);
    final currentPrice = widget.product.priceForWeight(_selectedWeight);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: widget.product),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.borderLight, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack with badges
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.25,
                  child: Image.asset(
                    widget.product.images.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.cardBgElevated,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppTheme.textMuted,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(80),
                          Colors.transparent,
                          AppTheme.cardBg.withAlpha(180),
                        ],
                      ),
                    ),
                  ),
                ),
                // Badges top row
                Positioned(
                  top: 8,
                  left: 8,
                  child: Row(
                    children: [
                      if (widget.product.discountPercent > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF476F),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${widget.product.discountPercent}% OFF',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      if (widget.product.isTodayCatch)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.accentCyan,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.flash_on,
                                  size: 11, color: AppTheme.darkBg),
                              const SizedBox(width: 2),
                              Text(
                                "Today's Catch",
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.darkBg,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: () => shop.toggleFavorite(widget.product.id),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 17,
                        color: isFav
                            ? const Color(0xFFEF476F)
                            : AppTheme.oceanWhite,
                      ),
                    ),
                  ),
                ),
                // Freshness indicator tag at bottom of image
                Positioned(
                  bottom: 6,
                  left: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.darkBg.withAlpha(190),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: AppTheme.lightCyan.withAlpha(40), width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.ac_unit,
                            size: 11, color: AppTheme.lightCyan),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.product.freshness,
                            style: GoogleFonts.inter(
                              fontSize: 9.5,
                              color: AppTheme.lightCyan,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.categoryName.toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentCyan,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.product.name,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.oceanWhite,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Weight Selector Dropdown/Chips
                  if (widget.product.weights.length > 1)
                    SizedBox(
                      height: 24,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.weights.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 5),
                        itemBuilder: (context, i) {
                          final w = widget.product.weights[i];
                          final isSelected = w == _selectedWeight;
                          return InkWell(
                            onTap: () => setState(() => _selectedWeight = w),
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.accentCyan.withAlpha(40)
                                    : AppTheme.cardBgElevated,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.accentCyan
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  w,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? AppTheme.accentCyan
                                        : AppTheme.textMuted,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Text(
                      _selectedWeight,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Price and Add to Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '₹${currentPrice.toInt()}',
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.oceanWhite,
                              ),
                            ),
                            if (widget.product.discountPercent > 0)
                              Text(
                                '₹${(widget.product.basePrice * (widget.product.priceForWeight(_selectedWeight) / widget.product.discountedPrice)).toInt()}',
                                style: GoogleFonts.inter(
                                  fontSize: 10.5,
                                  color: AppTheme.textMuted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Add Button
                      Material(
                        color: AppTheme.accentCyan,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            shop.addToCart(widget.product, _selectedWeight);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                                        'Added ${widget.product.name} ($_selectedWeight) to Cart',
                                        style: GoogleFonts.inter(
                                            color: AppTheme.oceanWhite,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: AppTheme.borderLight),
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: 14,
                                  color: AppTheme.darkBg,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'ADD',
                                  style: GoogleFonts.outfit(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.darkBg,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}

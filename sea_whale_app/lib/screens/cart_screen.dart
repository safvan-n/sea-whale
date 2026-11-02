import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../theme/app_theme.dart';
import 'tracking_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();
  String _selectedPaymentMethod = 'UPI';

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text(
          'Shopping Cart (${shop.cartCount})',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.oceanWhite,
          ),
        ),
        actions: [
          if (shop.cart.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined,
                  color: AppTheme.textMuted),
              tooltip: 'Clear Cart',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppTheme.cardBg,
                    title: Text('Clear Cart?',
                        style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
                    content: Text(
                      'Are you sure you want to remove all items from your cart?',
                      style: GoogleFonts.inter(color: AppTheme.textMuted),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          shop.clearCart();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Clear',
                            style: TextStyle(color: Color(0xFFEF476F))),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: shop.cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBgElevated,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: AppTheme.accentCyan,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your Cart is Empty',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.oceanWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore our fresh dock catch and seafood specials',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.explore_outlined, size: 18),
                    label: const Text('START SHOPPING'),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Delivery address info card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.accentCyan.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on_outlined,
                            color: AppTheme.accentCyan, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery to: Home',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.oceanWhite,
                              ),
                            ),
                            Text(
                              shop.deliveryAddress,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => _editAddressDialog(context, shop),
                        child: Text(
                          'CHANGE',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accentCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Cart Items List
                Text(
                  'Cart Items',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.oceanWhite,
                  ),
                ),
                const SizedBox(height: 10),

                ...shop.cart.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: Image.asset(
                              item.product.images.first,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.oceanWhite,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.cardBgElevated,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item.selectedWeight,
                                  style: GoogleFonts.inter(
                                    fontSize: 10.5,
                                    color: AppTheme.lightCyan,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${item.totalPrice.toInt()}',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.oceanWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Quantity controls
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.cardBgElevated,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.borderLight),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 14),
                                onPressed: () {
                                  shop.updateQuantity(
                                      item, item.quantity - 1);
                                },
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                color: AppTheme.oceanWhite,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '${item.quantity}',
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: AppTheme.oceanWhite,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 14),
                                onPressed: () {
                                  shop.updateQuantity(
                                      item, item.quantity + 1);
                                },
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                color: AppTheme.accentCyan,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 14),

                // Coupon Promo Code Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.confirmation_num_outlined,
                              size: 16, color: AppTheme.accentCyan),
                          const SizedBox(width: 8),
                          Text(
                            'Apply Coupon Code',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.oceanWhite,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _couponController,
                              style: GoogleFonts.outfit(
                                  color: AppTheme.oceanWhite, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Try OCEANFRESH or SEAWALE20',
                                hintStyle: GoogleFonts.inter(
                                    color: AppTheme.textMuted, fontSize: 12),
                                isDense: true,
                                filled: true,
                                fillColor: AppTheme.cardBgElevated,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                            ),
                            onPressed: () {
                              final success =
                                  shop.applyCoupon(_couponController.text);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppTheme.cardBgElevated,
                                    content: Text(
                                        'Coupon "${shop.appliedCoupon}" Applied! Saved ₹${shop.couponDiscount.toInt()}'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid coupon code!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('APPLY',
                                style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                      if (shop.appliedCoupon != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Applied: ${shop.appliedCoupon} (₹${shop.couponDiscount.toInt()} OFF)',
                                style: GoogleFonts.inter(
                                  color: AppTheme.successGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () => shop.removeCoupon(),
                                child: Text(
                                  'Remove',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFEF476F),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Bill Details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bill Summary',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildBillRow('Item Subtotal',
                          '₹${shop.cartSubtotal.toInt()}'),
                      _buildBillRow('Cold Chain Nitrogen Packaging',
                          '₹${shop.packagingFee.toInt()}'),
                      _buildBillRow(
                        'Delivery Fee',
                        shop.deliveryFee == 0
                            ? 'FREE'
                            : '₹${shop.deliveryFee.toInt()}',
                        isFree: shop.deliveryFee == 0,
                      ),
                      if (shop.couponDiscount > 0)
                        _buildBillRow(
                          'Promo Discount',
                          '- ₹${shop.couponDiscount.toInt()}',
                          isDiscount: true,
                        ),
                      const Divider(color: AppTheme.borderLight, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.oceanWhite,
                            ),
                          ),
                          Text(
                            '₹${shop.grandTotal.toInt()}',
                            style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.accentCyan,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 90),
              ],
            ),

      bottomSheet: shop.cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
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
                          'Total Payable',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        Text(
                          '₹${shop.grandTotal.toInt()}',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.oceanWhite,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _openCheckoutModal(context, shop),
                        child: const Text('PROCEED TO CHECKOUT'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildBillRow(String label, String value,
      {bool isFree = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 13, color: AppTheme.textMuted)),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDiscount
                  ? AppTheme.successGreen
                  : (isFree ? AppTheme.accentCyan : AppTheme.oceanWhite),
            ),
          ),
        ],
      ),
    );
  }

  void _editAddressDialog(BuildContext context, ShopProvider shop) {
    final controller = TextEditingController(text: shop.deliveryAddress);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.cardBg,
        title: Text('Edit Delivery Address',
            style: GoogleFonts.outfit(color: AppTheme.oceanWhite)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          style: GoogleFonts.inter(color: AppTheme.oceanWhite),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.cardBgElevated,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                shop.setDeliveryAddress(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _openCheckoutModal(BuildContext context, ShopProvider shop) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Payment Method',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.oceanWhite,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppTheme.textMuted),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildPaymentTile(
                    'UPI / Google Pay / PhonePe',
                    Icons.qr_code_scanner_rounded,
                    'Instant payment via any UPI App',
                    'UPI',
                    setModalState,
                  ),
                  _buildPaymentTile(
                    'Credit / Debit Card',
                    Icons.credit_card_rounded,
                    'Visa, Mastercard, RuPay',
                    'CARD',
                    setModalState,
                  ),
                  _buildPaymentTile(
                    'Cash on Delivery',
                    Icons.payments_outlined,
                    'Pay when chilled package arrives',
                    'COD',
                    setModalState,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showOrderSuccessModal(context, shop);
                      },
                      child: Text(
                        'PAY ₹${shop.grandTotal.toInt()} & PLACE ORDER',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentTile(
    String title,
    IconData icon,
    String subtitle,
    String methodKey,
    StateSetter setModalState,
  ) {
    final isSelected = _selectedPaymentMethod == methodKey;
    return InkWell(
      onTap: () {
        setModalState(() => _selectedPaymentMethod = methodKey);
        setState(() => _selectedPaymentMethod = methodKey);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentCyan.withAlpha(30)
              : AppTheme.cardBgElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.accentCyan : AppTheme.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? AppTheme.accentCyan : AppTheme.textMuted,
                size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
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
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: AppTheme.accentCyan, size: 20),
          ],
        ),
      ),
    );
  }

  void _showOrderSuccessModal(BuildContext context, ShopProvider shop) {
    final orderId =
        'SW-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final total = shop.grandTotal;
    shop.clearCart();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.accentCyan.withAlpha(35),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppTheme.accentCyan, size: 55),
            ),
            const SizedBox(height: 16),
            Text(
              'Order Confirmed!',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.oceanWhite,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Order #$orderId has been placed successfully.',
              style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBgElevated,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount Paid:',
                          style: GoogleFonts.inter(
                              color: AppTheme.textMuted, fontSize: 12)),
                      Text('₹${total.toInt()}',
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.oceanWhite)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimated Delivery:',
                          style: GoogleFonts.inter(
                              color: AppTheme.textMuted, fontSize: 12)),
                      Text('Today in 65 mins',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.accentCyan,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrackingScreen(orderId: orderId),
                    ),
                  );
                },
                icon: const Icon(Icons.radar_rounded, size: 18),
                label: const Text('TRACK COLD-CHAIN LIVE'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Back to Home',
                style: GoogleFonts.outfit(color: AppTheme.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

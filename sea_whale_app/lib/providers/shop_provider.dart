import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../models/cart_item.dart';
import '../data/mock_data.dart';

class ShopProvider extends ChangeNotifier {
  final List<Product> _allProducts = List.from(MockData.products);
  final List<CategoryItemModel> _categories = List.from(MockData.categories);

  final List<CartItem> _cart = [];
  final Set<String> _wishlistIds = {};
  String _selectedCategory = 'all';
  String _searchQuery = '';
  String? _appliedCoupon;
  double _couponDiscount = 0.0;
  String _deliveryAddress = 'Harbour Road, Kochi Marine Drive, Kerala 682031';
  String _deliverySlot = 'Today Express (Within 90 mins)';

  // Live cold chain tracking state
  double _containerTemp = 1.4;
  final String _containerStatus = 'In Transit - Chilled Nitrogen';

  List<Product> get allProducts => _allProducts;
  List<CategoryItemModel> get categories => _categories;
  List<CartItem> get cart => _cart;
  Set<String> get wishlistIds => _wishlistIds;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String? get appliedCoupon => _appliedCoupon;
  double get couponDiscount => _couponDiscount;
  String get deliveryAddress => _deliveryAddress;
  String get deliverySlot => _deliverySlot;
  double get containerTemp => _containerTemp;
  String get containerStatus => _containerStatus;

  int get cartCount {
    return _cart.fold(0, (sum, item) => sum + item.quantity);
  }

  double get cartSubtotal {
    return _cart.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get packagingFee => _cart.isEmpty ? 0.0 : 49.0;

  double get deliveryFee {
    if (_cart.isEmpty) return 0.0;
    return cartSubtotal >= 999 ? 0.0 : 60.0;
  }

  double get grandTotal {
    if (_cart.isEmpty) return 0.0;
    final total = cartSubtotal + packagingFee + deliveryFee - _couponDiscount;
    return total > 0 ? total : 0;
  }

  List<Product> get filteredProducts {
    return _allProducts.where((p) {
      final matchesCategory = _selectedCategory == 'all' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.categoryName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Product> get todayCatchProducts {
    return _allProducts.where((p) => p.isTodayCatch).toList();
  }

  List<Product> get bestSellerProducts {
    return _allProducts.where((p) => p.isBestSeller).toList();
  }

  bool isFavorite(String productId) => _wishlistIds.contains(productId);

  void toggleFavorite(String productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  void setCategory(String categoryId) {
    _selectedCategory = categoryId;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setDeliveryAddress(String address) {
    _deliveryAddress = address;
    notifyListeners();
  }

  void setDeliverySlot(String slot) {
    _deliverySlot = slot;
    notifyListeners();
  }

  void addToCart(Product product, String weight, {int quantity = 1}) {
    final existingIndex = _cart.indexWhere(
      (item) => item.product.id == product.id && item.selectedWeight == weight,
    );

    if (existingIndex >= 0) {
      _cart[existingIndex].quantity += quantity;
    } else {
      _cart.add(CartItem(
        product: product,
        selectedWeight: weight,
        quantity: quantity,
      ));
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      _cart.remove(item);
    } else {
      item.quantity = newQuantity;
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    _appliedCoupon = null;
    _couponDiscount = 0.0;
    notifyListeners();
  }

  bool applyCoupon(String code) {
    final clean = code.trim().toUpperCase();
    if (clean == 'OCEANFRESH') {
      _appliedCoupon = clean;
      _couponDiscount = 150.0;
      notifyListeners();
      return true;
    } else if (clean == 'SEAWALE20') {
      _appliedCoupon = clean;
      _couponDiscount = (cartSubtotal * 0.20).roundToDouble();
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeCoupon() {
    _appliedCoupon = null;
    _couponDiscount = 0.0;
    notifyListeners();
  }

  void updateTempTelemetry(double newTemp) {
    _containerTemp = newTemp;
    notifyListeners();
  }
}

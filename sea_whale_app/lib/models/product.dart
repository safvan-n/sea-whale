class Product {
  final String id;
  final String name;
  final String category;
  final String categoryName;
  final String description;
  final double basePrice;
  final int discountPercent;
  final String freshness;
  final List<String> weights;
  final List<String> images;
  final bool isBestSeller;
  final bool isTodayCatch;
  final double rating;
  final int reviewCount;
  final String origin;
  final String storageTemp;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryName,
    required this.description,
    required this.basePrice,
    required this.discountPercent,
    required this.freshness,
    required this.weights,
    required this.images,
    this.isBestSeller = false,
    this.isTodayCatch = false,
    this.rating = 4.9,
    this.reviewCount = 128,
    this.origin = 'Direct Catch / Dock Flown',
    this.storageTemp = '0°C to 2°C Sub-Zero',
  });

  double get discountedPrice {
    if (discountPercent <= 0) return basePrice;
    return basePrice - (basePrice * discountPercent / 100);
  }

  double priceForWeight(String weight) {
    double factor = 1.0;
    if (weight.contains('250g')) factor = 0.55;
    if (weight.contains('500g')) factor = 1.0;
    if (weight.contains('1kg')) factor = 1.9;
    if (weight.contains('1 Unit')) factor = 1.0;
    if (weight.contains('2 Units')) factor = 1.9;
    if (weight.contains('Pack of 6')) factor = 1.0;
    if (weight.contains('Pack of 12')) factor = 1.85;
    if (weight.contains('400g')) factor = 0.85;

    return (discountedPrice * factor).roundToDouble();
  }
}

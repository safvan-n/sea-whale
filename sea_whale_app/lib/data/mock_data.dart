import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';

class MockData {
  static const List<CategoryItemModel> categories = [
    CategoryItemModel(
      id: 'fresh-fish',
      name: 'Fresh Fish',
      icon: Icons.sailing_rounded,
      description: 'Dock-fresh marine and river fish selections flown in ice.',
      accentColor: Color(0xFF00B4D8),
    ),
    CategoryItemModel(
      id: 'prawns',
      name: 'Prawns',
      icon: Icons.waves_rounded,
      description: 'Sweet, cleaned tiger and white ocean prawns.',
      accentColor: Color(0xFFFF7B54),
    ),
    CategoryItemModel(
      id: 'crab',
      name: 'Crab',
      icon: Icons.shield_moon_rounded,
      description: 'Meaty mud crabs and blue swimmer coastal crabs.',
      accentColor: Color(0xFFFFB26B),
    ),
    CategoryItemModel(
      id: 'mutton',
      name: 'Mutton',
      icon: Icons.restaurant_rounded,
      description: 'Tender grass-fed mountain goat & rich curry cuts.',
      accentColor: Color(0xFFE0A96D),
    ),
    CategoryItemModel(
      id: 'chicken',
      name: 'Chicken',
      icon: Icons.egg_outlined,
      description: 'Juicy, hormone-free country chicken cuts.',
      accentColor: Color(0xFFFFD56B),
    ),
    CategoryItemModel(
      id: 'beef',
      name: 'Beef',
      icon: Icons.military_tech_rounded,
      description: 'Imported prime Wagyu & marbled beef steaks.',
      accentColor: Color(0xFFEF476F),
    ),
    CategoryItemModel(
      id: 'seafood',
      name: 'Seafood',
      icon: Icons.anchor_rounded,
      description: 'Calamari, lobsters, squid, and shellfish.',
      accentColor: Color(0xFF48CAE4),
    ),
    CategoryItemModel(
      id: 'eggs',
      name: 'Eggs',
      icon: Icons.egg_alt_rounded,
      description: 'Organic free-range country brown eggs.',
      accentColor: Color(0xFFFFC074),
    ),
    CategoryItemModel(
      id: 'frozen-foods',
      name: 'Frozen Foods',
      icon: Icons.ac_unit_rounded,
      description: 'Premium cold chain processed appetizers & fish fingers.',
      accentColor: Color(0xFF90E0EF),
    ),
  ];

  static const List<Product> products = [
    Product(
      id: 'atlantic-salmon',
      name: 'Atlantic Salmon Fillet Portions',
      category: 'fresh-fish',
      categoryName: 'Fresh Fish',
      description:
          'Premium orange-pink Atlantic Salmon portions, high in Omega-3 fatty acids. Skin-on, boneless, and sliced under sub-zero temperatures. Sourced from cold Norwegian fjords and flown in dry-nitrogen chilled capsules directly to port docks.',
      basePrice: 1299,
      discountPercent: 15,
      freshness: '100% Insured (0-2°C Transit)',
      weights: ['250g', '500g', '1kg'],
      images: [
        'assets/fresh_catch.png',
        'assets/seafood_platter.png',
        'assets/logistics.png'
      ],
      isBestSeller: true,
      isTodayCatch: true,
      origin: 'Norwegian Fjords (Dock Flown)',
      storageTemp: '0°C to 2°C Nitrogen Chilled',
    ),
    Product(
      id: 'black-tiger-prawns',
      name: 'Jumbo Black Tiger Prawns',
      category: 'prawns',
      categoryName: 'Prawns',
      description:
          'Crisp, sweet, and plump jumbo Tiger Prawns, fully cleaned, deveined, and tail-on. Flash frozen on dock vessels within 30 minutes of harvest to ensure firm meat texture and lock in natural maritime sweetness.',
      basePrice: 890,
      discountPercent: 10,
      freshness: 'Dock Fresh (Sub-Zero Sealed)',
      weights: ['500g', '1kg'],
      images: [
        'assets/prawns_product.png',
        'assets/seafood_platter.png',
        'assets/fresh_catch.png'
      ],
      isBestSeller: true,
      isTodayCatch: false,
      origin: 'Bay of Bengal Deep Sea Catch',
      storageTemp: '-18°C Cryo-Lock Sealed',
    ),
    Product(
      id: 'mud-crabs-live',
      name: 'Gourmet Mud Crabs (Live/Frozen)',
      category: 'crab',
      categoryName: 'Crab',
      description:
          'Massive, fleshy Mud Crabs sourced from coastal mangrove estuaries. Known for their dense, sweet claw meat. Handpicked and packed in humidity-insulated boxes or cleaned and vacuum frozen for instant gourmet cooking.',
      basePrice: 1599,
      discountPercent: 20,
      freshness: 'Alive / Flash-Frozen Guaranteed',
      weights: ['1 Unit (approx 600g)', '2 Units (approx 1.2kg)'],
      images: [
        'assets/seafood_platter.png',
        'assets/prawns_product.png',
        'assets/fresh_catch.png'
      ],
      isBestSeller: false,
      isTodayCatch: true,
      origin: 'Sundarbans Estuary Marine Catch',
      storageTemp: 'Vessel Chilled Live Transport',
    ),
    Product(
      id: 'goat-biryani-cut',
      name: 'Premium Goat Biryani Cut',
      category: 'mutton',
      categoryName: 'Mutton',
      description:
          'Tender bone-in goat meat chunks curated specifically for dum biryani. Sourced from grass-fed mountain goats, aged properly under chilled settings, and cut into uniform shapes. 100% chemical and hormone-free.',
      basePrice: 780,
      discountPercent: 5,
      freshness: 'Chilled (Never Frozen)',
      weights: ['500g', '1kg'],
      images: [
        'assets/meat_product.png',
        'assets/fresh_catch.png',
        'assets/hero_banner.png'
      ],
      isBestSeller: true,
      isTodayCatch: false,
      origin: 'Himalayan Foothills Pasture',
      storageTemp: '0°C to 4°C Fresh Chilled',
    ),
    Product(
      id: 'chicken-breast-boneless',
      name: 'Farm Raised Chicken Breast',
      category: 'chicken',
      categoryName: 'Chicken',
      description:
          'Juicy, lean, skinless boneless chicken breast portions. Cultured in bio-secure clean environments and processed under strict temperature-controlled sanitary standards. Dry-packed to ensure zero water retention.',
      basePrice: 320,
      discountPercent: 0,
      freshness: 'Fresh Chilled (0-4°C)',
      weights: ['500g', '1kg'],
      images: [
        'assets/meat_product.png',
        'assets/hero_banner.png',
        'assets/fresh_catch.png'
      ],
      isBestSeller: true,
      isTodayCatch: false,
      origin: 'Bio-Secure Farm Harvest',
      storageTemp: '0°C to 4°C Constant Chilling',
    ),
    Product(
      id: 'wagyu-ribeye-steak',
      name: 'Wagyu Ribeye Steak (Imported)',
      category: 'beef',
      categoryName: 'Beef',
      description:
          'Ultra-luxurious Wagyu Beef ribeye cut with exceptional A5 marbling. Sourced from certified Japanese farms, frozen under rapid sub-zero cryo-conditions, and packaged in protective nitrogen cells for gourmet steak pan-searing.',
      basePrice: 4200,
      discountPercent: 12,
      freshness: 'Cryo-Lock Frozen (-18°C)',
      weights: ['250g', '500g'],
      images: [
        'assets/meat_product.png',
        'assets/seafood_platter.png',
        'assets/fresh_catch.png'
      ],
      isBestSeller: false,
      isTodayCatch: false,
      origin: 'Kagoshima Prefecture, Japan',
      storageTemp: '-18°C Cryogenic Frozen',
    ),
    Product(
      id: 'calamari-rings-premium',
      name: 'Premium Calamari Rings',
      category: 'seafood',
      categoryName: 'Seafood',
      description:
          'Tender squid tubes sliced into perfect uniform rings. Cleaned and prepared under ice beds. Extremely versatile for pan frying, crispy crumb coating, or adding to rich maritime paellas.',
      basePrice: 590,
      discountPercent: 8,
      freshness: 'Vessel Frozen (-30°C Log)',
      weights: ['400g'],
      images: [
        'assets/seafood_platter.png',
        'assets/prawns_product.png',
        'assets/hero_banner.png'
      ],
      isBestSeller: false,
      isTodayCatch: true,
      origin: 'Arabian Sea Deep Waters',
      storageTemp: '-30°C Vessel Flash Freeze',
    ),
    Product(
      id: 'organic-farm-eggs',
      name: 'Farm Fresh Organic Eggs',
      category: 'eggs',
      categoryName: 'Eggs',
      description:
          'Free-range organic brown eggs high in lutein and proteins. Sourced daily from certified green farms and shipped in eco-friendly protective pulp cartons.',
      basePrice: 180,
      discountPercent: 0,
      freshness: 'Daily Farm Harvested',
      weights: ['Pack of 6', 'Pack of 12'],
      images: [
        'assets/fresh_catch.png',
        'assets/hero_banner.png',
        'assets/seafood_platter.png'
      ],
      isBestSeller: false,
      isTodayCatch: false,
      origin: 'Green Pastures Organic Farms',
      storageTemp: 'Room Temp / Cool Stored',
    ),
    Product(
      id: 'cold-chain-fish-fingers',
      name: 'Crumbed Cod Fish Fingers',
      category: 'frozen-foods',
      categoryName: 'Frozen Foods',
      description:
          'Made from 100% white Atlantic Cod fillets, breaded with gourmet seasoned breadcrumbs, and pre-packaged in dry cold storage chambers. Simple, fast, and satisfyingly crispy.',
      basePrice: 290,
      discountPercent: 10,
      freshness: 'Unbroken Cold Lock (-18°C)',
      weights: ['250g', '500g'],
      images: [
        'assets/seafood_platter.png',
        'assets/hero_banner.png',
        'assets/fresh_catch.png'
      ],
      isBestSeller: false,
      isTodayCatch: false,
      origin: 'North Atlantic Marine Catch',
      storageTemp: '-18°C Continuous Cold Chain',
    ),
  ];
}

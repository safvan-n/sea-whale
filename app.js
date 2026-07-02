// Sea Whale Transport - Application Controller (Vanilla JS)

// 1. Mock Data: Premium Products Database
const products = [
    {
        id: 'atlantic-salmon',
        name: 'Atlantic Salmon Fillet Portions',
        category: 'fresh-fish',
        categoryName: 'Fresh Fish',
        description: 'Premium orange-pink Atlantic Salmon portions, high in Omega-3 fatty acids. Skin-on, boneless, and sliced under sub-zero temperatures. Sourced from cold Norwegian fjords and flown in dry-nitrogen chilled capsules directly to port docks.',
        basePrice: 1299,
        discountPercent: 15,
        freshness: '100% Insured (0-2°C Transit)',
        weights: ['250g', '500g', '1kg'],
        images: ['assets/fresh_catch.png', 'assets/seafood_platter.png', 'assets/logistics.png'],
        isBestSeller: true,
        isTodayCatch: true
    },
    {
        id: 'black-tiger-prawns',
        name: 'Jumbo Black Tiger Prawns',
        category: 'prawns',
        categoryName: 'Prawns',
        description: 'Crisp, sweet, and plump jumbo Tiger Prawns, fully cleaned, deveined, and tail-on. Flash frozen on dock vessels within 30 minutes of harvest to ensure firm meat texture and lock in natural maritime sweetness.',
        basePrice: 890,
        discountPercent: 10,
        freshness: 'Dock Fresh (Sub-Zero Sealed)',
        weights: ['500g', '1kg'],
        images: ['assets/prawns_product.png', 'assets/seafood_platter.png', 'assets/fresh_catch.png'],
        isBestSeller: true,
        isTodayCatch: false
    },
    {
        id: 'mud-crabs-live',
        name: 'Gourmet Mud Crabs (Live/Frozen)',
        category: 'crab',
        categoryName: 'Crab',
        description: 'Massive, fleshy Mud Crabs sourced from coastal estuaries. Known for their dense, sweet claw meat. Handpicked and packed in humidity-insulated boxes or cleaned and vacuum frozen for instant cooking.',
        basePrice: 1599,
        discountPercent: 20,
        freshness: 'Alive or Flash-Frozen',
        weights: ['1 Unit (approx 600g)', '2 Units (approx 1.2kg)'],
        images: ['assets/seafood_platter.png', 'assets/prawns_product.png', 'assets/fresh_catch.png'],
        isBestSeller: false,
        isTodayCatch: true
    },
    {
        id: 'goat-biryani-cut',
        name: 'Premium Goat Biryani Cut',
        category: 'mutton',
        categoryName: 'Mutton',
        description: 'Tender bone-in goat meat chunks curated specifically for biryani. Sourced from grass-fed mountain goats, aged properly under chilled settings, and cut into uniform shapes. 100% chemical and hormone-free.',
        basePrice: 780,
        discountPercent: 5,
        freshness: 'Chilled (Never Frozen)',
        weights: ['500g', '1kg'],
        images: ['assets/meat_product.png', 'assets/fresh_catch.png', 'assets/hero_banner.png'],
        isBestSeller: true,
        isTodayCatch: false
    },
    {
        id: 'chicken-breast-boneless',
        name: 'Farm Raised Chicken Breast (Boneless)',
        category: 'chicken',
        categoryName: 'Chicken',
        description: 'Juicy, lean, skinless boneless chicken breast portions. Cultured in clean biological environments and processed under strict temperature-controlled sanitary standards. Dry-packed to ensure zero water retention.',
        basePrice: 320,
        discountPercent: 0,
        freshness: 'Fresh Chilled (0-4°C)',
        weights: ['500g', '1kg'],
        images: ['assets/meat_product.png', 'assets/hero_banner.png', 'assets/fresh_catch.png'],
        isBestSeller: true,
        isTodayCatch: false
    },
    {
        id: 'wagyu-ribeye-steak',
        name: 'Wagyu Ribeye Steak (Imported)',
        category: 'beef',
        categoryName: 'Beef',
        description: 'Ultra-luxurious Wagyu Beef ribeye cut with exceptional marbling. Sourced from certified Japanese farms, frozen under rapid sub-zero cryo-conditions, and packaged in protective nitrogen cells for gourmet steak pan-searing.',
        basePrice: 4200,
        discountPercent: 12,
        freshness: 'Cryo-Lock Frozen (-18°C)',
        weights: ['250g', '500g'],
        images: ['assets/meat_product.png', 'assets/seafood_platter.png', 'assets/fresh_catch.png'],
        isBestSeller: false,
        isTodayCatch: false
    },
    {
        id: 'calamari-rings-premium',
        name: 'Premium Calamari Rings',
        category: 'seafood',
        categoryName: 'Seafood',
        description: 'Tender squid tubes sliced into perfect rings. Cleaned and prepared under ice beds. Extremely versatile for pan frying, crumb coating, or adding to rich maritime paellas.',
        basePrice: 590,
        discountPercent: 8,
        freshness: 'Vessel Frozen (-30°C Log)',
        weights: ['400g'],
        images: ['assets/seafood_platter.png', 'assets/prawns_product.png', 'assets/hero_banner.png'],
        isBestSeller: false,
        isTodayCatch: true
    },
    {
        id: 'organic-farm-eggs',
        name: 'Farm Fresh Organic Eggs',
        category: 'eggs',
        categoryName: 'Eggs',
        description: 'Free-range organic brown eggs high in lutein and proteins. Sourced daily from certified green farms and shipped in eco-friendly protective pulp cartons.',
        basePrice: 180,
        discountPercent: 0,
        freshness: 'Daily Farm Harvested',
        weights: ['Pack of 6', 'Pack of 12'],
        images: ['assets/fresh_catch.png', 'assets/hero_banner.png', 'assets/seafood_platter.png'],
        isBestSeller: false,
        isTodayCatch: false
    },
    {
        id: 'cold-chain-fish-fingers',
        name: 'Crumbed Cod Fish Fingers',
        category: 'frozen-foods',
        categoryName: 'Frozen Foods',
        description: 'Made from 100% white Atlantic Cod fillets, breaded with gourmet breadcrumbs, and pre-packaged in dry cold storage chambers. Simple, fast, and satisfyingly crispy.',
        basePrice: 290,
        discountPercent: 10,
        freshness: 'Unbroken Cold Lock (-18°C)',
        weights: ['250g', '500g'],
        images: ['assets/seafood_platter.png', 'assets/hero_banner.png', 'assets/fresh_catch.png'],
        isBestSeller: false,
        isTodayCatch: false
    }
];

// Categories definition
const categories = [
    { id: 'fresh-fish', name: 'Fresh Fish', icon: 'anchor', desc: 'Dock-fresh marine and river fish selections.' },
    { id: 'chicken', name: 'Chicken', icon: 'egg', desc: 'Juicy, hormone-free country chicken cuts.' },
    { id: 'mutton', name: 'Mutton', icon: 'shield', desc: 'Tender grass-fed mountain goat & lamb.' },
    { id: 'beef', name: 'Beef', icon: 'award', desc: 'Imported prime Wagyu & marbled beef steaks.' },
    { id: 'prawns', name: 'Prawns', icon: 'waves', desc: 'Sweet, cleaned tiger and white prawns.' },
    { id: 'crab', name: 'Crab', icon: 'compass', desc: 'Meaty mud crabs and blue swimmer crabs.' },
    { id: 'seafood', name: 'Seafood', icon: 'ship', desc: 'Calamari, lobsters, squid, and shellfish.' },
    { id: 'eggs', name: 'Eggs', icon: 'egg-toast', desc: 'Organic free-range country brown eggs.' },
    { id: 'frozen-foods', name: 'Frozen Foods', icon: 'snowflake', desc: 'Premium cold chain processed appetizers.' }
];

// 2. Global State Manager
let cart = [];
let activeTestimonialIndex = 0;

// Initialize app when DOM loads
document.addEventListener('DOMContentLoaded', () => {
    initApp();
});

function initApp() {
    // Generate Ambient Bubbles
    generateAmbientBubbles();
    
    // Inject Dynamic Page Data
    injectHomeCategories();
    injectHomeProducts();
    injectStorefrontFilters();
    injectStorefrontProducts('all');
    injectCategoriesPage();
    
    // SPA Router setup
    window.addEventListener('hashchange', router);
    router(); // run router once initially
    
    // Register general UI event listeners
    registerUIEventListeners();
    
    // Initial Icons render
    lucide.createIcons();
}

// 3. Ambient Floating Bubbles Generator
function generateAmbientBubbles() {
    const container = document.getElementById('bubble-container');
    if (!container) return;
    
    const bubbleCount = 18;
    for (let i = 0; i < bubbleCount; i++) {
        const bubble = document.createElement('div');
        bubble.classList.add('bubble');
        
        // Randomize bubble details
        const size = Math.random() * 35 + 10; // 10px to 45px
        const left = Math.random() * 100; // 0% to 100%
        const delay = Math.random() * 8; // 0s to 8s
        const duration = Math.random() * 8 + 8; // 8s to 16s
        
        bubble.style.width = `${size}px`;
        bubble.style.height = `${size}px`;
        bubble.style.left = `${left}%`;
        bubble.style.animationDelay = `${delay}s`;
        bubble.style.animationDuration = `${duration}s`;
        
        container.appendChild(bubble);
    }
}

// 4. SPA Router
function router() {
    const hash = window.location.hash || '#home';
    let targetSectionId = hash.substring(1);
    
    // Check if we are viewing product details
    if (targetSectionId.startsWith('product-details-')) {
        const productId = targetSectionId.replace('product-details-', '');
        renderProductDetailsPage(productId);
        targetSectionId = 'product-details';
    }
    
    const sections = document.querySelectorAll('.page-section');
    let targetSection = document.getElementById(targetSectionId);
    
    // Fallback if section does not exist
    if (!targetSection) {
        targetSection = document.getElementById('home');
        targetSectionId = 'home';
    }
    
    // Remove active class from all sections and hide them
    sections.forEach(sec => {
        sec.classList.remove('active');
    });
    
    // Show active section and scroll to top
    targetSection.classList.add('active');
    window.scrollTo({ top: 0, behavior: 'smooth' });
    
    // Update Active Navigation Link Class
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.classList.remove('active');
        const href = link.getAttribute('href');
        if (href === `#${targetSectionId}`) {
            link.classList.add('active');
        }
    });
    
    // Auto-close hamburger menu on route transition
    const navMenu = document.getElementById('nav-menu');
    if (navMenu) navMenu.classList.remove('open');
}

// 5. Inject Content Dynamically
function injectHomeCategories() {
    const grid = document.getElementById('home-categories-grid');
    if (!grid) return;
    
    // Render 6 categories on home page
    const featuredCats = categories.slice(0, 6);
    grid.innerHTML = featuredCats.map(cat => `
        <div class="category-card glass" onclick="filterStorefrontAndNavigate('${cat.id}')">
            <div class="category-icon-box">
                <i data-lucide="${cat.icon || 'anchor'}"></i>
            </div>
            <h3>${cat.name}</h3>
        </div>
    `).join('');
}

function injectHomeProducts() {
    const bestsellerGrid = document.getElementById('home-bestsellers-grid');
    const freshcatchGrid = document.getElementById('home-freshcatch-grid');
    
    if (bestsellerGrid) {
        const bestsellers = products.filter(p => p.isBestSeller).slice(0, 4);
        bestsellerGrid.innerHTML = bestsellers.map(p => renderProductCard(p)).join('');
    }
    
    if (freshcatchGrid) {
        const freshCatches = products.filter(p => p.isTodayCatch).slice(0, 4);
        freshcatchGrid.innerHTML = freshCatches.map(p => renderProductCard(p)).join('');
    }
}

function injectStorefrontFilters() {
    const list = document.getElementById('category-filters-list');
    if (!list) return;
    
    // Clear default except "All"
    list.innerHTML = `<button class="filter-chip active" data-category="all">All Selections</button>`;
    
    categories.forEach(cat => {
        const btn = document.createElement('button');
        btn.classList.add('filter-chip');
        btn.setAttribute('data-category', cat.id);
        btn.textContent = cat.name;
        list.appendChild(btn);
    });
    
    // Add Click listener for filters
    const chips = list.querySelectorAll('.filter-chip');
    chips.forEach(chip => {
        chip.addEventListener('click', () => {
            chips.forEach(c => c.classList.remove('active'));
            chip.classList.add('active');
            
            const category = chip.getAttribute('data-category');
            injectStorefrontProducts(category);
        });
    });
}

function injectStorefrontProducts(categoryFilter, searchQuery = '') {
    const grid = document.getElementById('storefront-products-grid');
    const countEl = document.getElementById('products-count');
    if (!grid) return;
    
    let filtered = products;
    
    // Filter by Category
    if (categoryFilter && categoryFilter !== 'all') {
        filtered = products.filter(p => p.category === categoryFilter);
    }
    
    // Filter by Search Query
    if (searchQuery) {
        const query = searchQuery.toLowerCase();
        filtered = filtered.filter(p => p.name.toLowerCase().includes(query) || p.description.toLowerCase().includes(query) || p.categoryName.toLowerCase().includes(query));
    }
    
    // Apply Sorting
    const sortVal = document.getElementById('sort-select')?.value || 'default';
    if (sortVal === 'price-low') {
        filtered.sort((a, b) => getPrice(a) - getPrice(b));
    } else if (sortVal === 'price-high') {
        filtered.sort((a, b) => getPrice(b) - getPrice(a));
    } else {
        // Default premium sort (Bestsellers first)
        filtered.sort((a, b) => (b.isBestSeller ? 1 : 0) - (a.isBestSeller ? 1 : 0));
    }
    
    grid.innerHTML = filtered.map(p => renderProductCard(p)).join('');
    
    if (countEl) {
        countEl.textContent = `Showing ${filtered.length} products`;
    }
    
    lucide.createIcons();
}

function injectCategoriesPage() {
    const grid = document.getElementById('categories-page-grid');
    if (!grid) return;
    
    grid.innerHTML = categories.map(cat => {
        // find a product image in this category to use as card background, fallback to hero_banner
        const matchingProd = products.find(p => p.category === cat.id);
        const img = matchingProd ? matchingProd.images[0] : 'assets/hero_banner.png';
        
        return `
            <div class="category-large-card" onclick="filterStorefrontAndNavigate('${cat.id}')">
                <div class="cat-bg-img" style="background-image: url('${img}');"></div>
                <div class="cat-large-overlay">
                    <h3>${cat.name}</h3>
                    <p>${cat.desc} <i data-lucide="arrow-right"></i></p>
                </div>
            </div>
        `;
    }).join('');
}

// Helper: Calculate price based on discount
function getPrice(product) {
    if (product.discountPercent > 0) {
        return Math.round(product.basePrice * (1 - product.discountPercent / 100));
    }
    return product.basePrice;
}

// Helper: Render HTML for Product Card
function renderProductCard(p) {
    const discPrice = getPrice(p);
    const hasDiscount = p.discountPercent > 0;
    
    // Build weight dropdown options
    const weightOptions = p.weights.map(w => `<option value="${w}">${w}</option>`).join('');
    
    return `
        <div class="product-card glass" data-id="${p.id}">
            <div class="product-img-wrapper" onclick="window.location.hash='#product-details-${p.id}'">
                <img src="${p.images[0]}" alt="${p.name}" class="product-img">
                <span class="freshness-badge ${p.isBestSeller ? 'bg-accent' : ''}">
                    <i data-lucide="${p.isBestSeller ? 'award' : 'shield'}"></i>
                    ${p.isBestSeller ? 'Best Seller' : p.freshness.split(' ')[0]}
                </span>
            </div>
            
            <div class="product-info">
                <span class="product-cat">${p.categoryName}</span>
                <h3 class="product-title" onclick="window.location.hash='#product-details-${p.id}'" style="cursor:pointer">${p.name}</h3>
                
                <div class="product-meta-row">
                    <select class="weight-select" id="weight-${p.id}" onchange="updateCardPrice('${p.id}')">
                        ${weightOptions}
                    </select>
                    
                    <div class="product-price-box">
                        ${hasDiscount ? `<span class="old-price">₹${p.basePrice}</span>` : ''}
                        <span class="new-price" id="price-display-${p.id}">₹${discPrice}</span>
                        ${hasDiscount ? `<span class="discount-badge">${p.discountPercent}% OFF</span>` : ''}
                    </div>
                </div>
                
                <div class="product-actions">
                    <button class="btn btn-secondary" onclick="addToCartFromStore('${p.id}')">Add to Cart</button>
                    <button class="btn btn-primary" onclick="buyNowFromStore('${p.id}')">Buy Now</button>
                </div>
            </div>
        </div>
    `;
}

// 6. Dynamic Card Action: Update Price based on Weight selection
window.updateCardPrice = function(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;
    
    const weightSelect = document.getElementById(`weight-${productId}`);
    if (!weightSelect) return;
    
    const selectedWeight = weightSelect.value;
    const priceDisplay = document.getElementById(`price-display-${productId}`);
    
    // Scale price slightly by weight option index
    const weightIndex = product.weights.indexOf(selectedWeight);
    let multiplier = 1;
    if (weightIndex === 1) multiplier = 1.8;
    if (weightIndex === 2) multiplier = 3.2;
    
    const scaledPrice = Math.round(getPrice(product) * multiplier);
    if (priceDisplay) {
        priceDisplay.textContent = `₹${scaledPrice}`;
    }
};

// 7. Render Product Details Page
function renderProductDetailsPage(productId) {
    const container = document.getElementById('product-details-content');
    if (!container) return;
    
    const product = products.find(p => p.id === productId);
    if (!product) {
        container.innerHTML = `<p class="text-center">Selection not found.</p>`;
        return;
    }
    
    const discPrice = getPrice(product);
    const hasDiscount = product.discountPercent > 0;
    
    // Generate weight chips
    const weightChips = product.weights.map((w, index) => `
        <button class="weight-chip ${index === 0 ? 'active' : ''}" data-weight="${w}" onclick="selectDetailsWeight(this, '${product.id}')">${w}</button>
    `).join('');
    
    // Generate thumbnails images
    const thumbnails = product.images.map((img, index) => `
        <div class="thumb-image ${index === 0 ? 'active' : ''}" onclick="changeDetailsGalleryImage(this, '${img}')">
            <img src="${img}" alt="${product.name} Gallery ${index + 1}">
        </div>
    `).join('');
    
    container.innerHTML = `
        <!-- Details Gallery Grid -->
        <div class="details-gallery">
            <div class="main-image-box">
                <img src="${product.images[0]}" alt="${product.name}" class="main-gallery-image" id="details-main-img">
                <span class="freshness-badge bg-accent"><i data-lucide="shield-check"></i> 100% Quality Protected</span>
            </div>
            <div class="thumbnails-strip">
                ${thumbnails}
            </div>
        </div>
        
        <!-- Details Information -->
        <div class="details-info">
            <span class="sub-title">${product.categoryName}</span>
            <h2 class="details-title">${product.name}</h2>
            
            <div class="details-price-row">
                ${hasDiscount ? `<span class="old-price">₹${product.basePrice}</span>` : ''}
                <span class="new-price" id="details-price-display" data-base-price="${discPrice}">₹${discPrice}</span>
                ${hasDiscount ? `<span class="discount-badge">${product.discountPercent}% OFF</span>` : ''}
            </div>
            
            <p class="details-description">${product.description}</p>
            
            <div class="details-freshness-info">
                <i data-lucide="truck" class="fresh-info-icon"></i>
                <div>
                    <h5>Insured Nitrogen-Chilled Sourcing</h5>
                    <p>Shipped directly from docking vessels in Visakhapatnam Port via Sea Whale refrigerated reefer pods. Vacuum sealed under active Nitrogen vapor.</p>
                </div>
            </div>
            
            <!-- Weight Choice -->
            <div class="details-weight-selector">
                <h5>Select Net Weight</h5>
                <div class="weight-chips-group" id="details-weight-chips">
                    ${weightChips}
                </div>
            </div>
            
            <!-- Quantity Box & Add button -->
            <div class="details-actions-panel">
                <div class="details-qty-box">
                    <button class="details-qty-btn" onclick="adjustDetailsQty(-1)">-</button>
                    <span class="details-qty-val" id="details-qty-val">1</span>
                    <button class="details-qty-btn" onclick="adjustDetailsQty(1)">+</button>
                </div>
                
                <button class="btn btn-secondary" onclick="addDetailsToCart('${product.id}')">Add to Cart</button>
                <button class="btn btn-primary" onclick="buyDetailsNow('${product.id}')">Buy Now</button>
            </div>
        </div>
    `;
    
    // Inject Recommended Products (similar items from same category, excluding current product)
    const similarGrid = document.getElementById('similar-products-grid');
    if (similarGrid) {
        const similar = products.filter(p => p.category === product.category && p.id !== product.id).slice(0, 3);
        if (similar.length > 0) {
            similarGrid.innerHTML = similar.map(p => renderProductCard(p)).join('');
            document.querySelector('.similar-products-wrapper').style.display = 'block';
        } else {
            // Pick any 3 bestsellers
            const fallbackSimilar = products.filter(p => p.id !== product.id).slice(0, 3);
            similarGrid.innerHTML = fallbackSimilar.map(p => renderProductCard(p)).join('');
        }
    }
    
    lucide.createIcons();
}

// 8. Product Details Interactivity
window.changeDetailsGalleryImage = function(thumbEl, imageSrc) {
    const mainImg = document.getElementById('details-main-img');
    if (mainImg) mainImg.src = imageSrc;
    
    const thumbs = document.querySelectorAll('.thumb-image');
    thumbs.forEach(t => t.classList.remove('active'));
    thumbEl.classList.add('active');
};

window.selectDetailsWeight = function(chipEl, productId) {
    const chips = document.querySelectorAll('.weight-chip');
    chips.forEach(c => c.classList.remove('active'));
    chipEl.classList.add('active');
    
    const selectedWeight = chipEl.getAttribute('data-weight');
    const priceDisplay = document.getElementById('details-price-display');
    const product = products.find(p => p.id === productId);
    
    if (priceDisplay && product) {
        const weightIndex = product.weights.indexOf(selectedWeight);
        let multiplier = 1;
        if (weightIndex === 1) multiplier = 1.8;
        if (weightIndex === 2) multiplier = 3.2;
        
        const scaledPrice = Math.round(getPrice(product) * multiplier);
        priceDisplay.textContent = `₹${scaledPrice}`;
        
        // Also update quantity scale calculation
        adjustDetailsQty(0);
    }
};

window.adjustDetailsQty = function(change) {
    const qtyVal = document.getElementById('details-qty-val');
    if (!qtyVal) return;
    
    let currentQty = parseInt(qtyVal.textContent);
    currentQty += change;
    if (currentQty < 1) currentQty = 1;
    if (currentQty > 20) currentQty = 20;
    
    qtyVal.textContent = currentQty;
};

// 9. Shopping Cart Controller Logic
function updateCartUI() {
    const cartBadge = document.getElementById('cart-badge');
    const emptyState = document.getElementById('empty-cart-state');
    const cartItemsWrapper = document.getElementById('cart-items');
    const cartFooter = document.getElementById('cart-footer');
    const cartBody = document.getElementById('cart-body');
    const cartSubtotal = document.getElementById('cart-subtotal');
    
    // Count unique items or total items
    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    if (cartBadge) {
        cartBadge.textContent = totalItems;
        if (totalItems > 0) {
            cartBadge.style.display = 'flex';
        } else {
            cartBadge.style.display = 'none';
        }
    }
    
    if (totalItems === 0) {
        emptyState.style.display = 'flex';
        cartItemsWrapper.style.display = 'none';
        cartFooter.style.display = 'none';
    } else {
        emptyState.style.display = 'none';
        cartItemsWrapper.style.display = 'flex';
        cartFooter.style.display = 'block';
        
        // Calculate Subtotal
        const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        if (cartSubtotal) {
            cartSubtotal.textContent = `₹${subtotal.toLocaleString('en-IN')}`;
        }
        
        // Render Item cards
        cartItemsWrapper.innerHTML = cart.map((item, index) => `
            <div class="cart-item">
                <img src="${item.product.images[0]}" alt="${item.product.name}" class="cart-item-img">
                <div class="cart-item-info">
                    <div>
                        <div class="cart-item-title">${item.product.name}</div>
                        <div class="cart-item-meta">${item.weight} | ₹${item.price} each</div>
                    </div>
                    
                    <div class="cart-item-controls">
                        <div class="qty-counter">
                            <button class="qty-btn" onclick="updateCartItemQty(${index}, -1)">-</button>
                            <span class="qty-number">${item.quantity}</span>
                            <button class="qty-btn" onclick="updateCartItemQty(${index}, 1)">+</button>
                        </div>
                        
                        <button class="remove-item-btn" onclick="removeCartItem(${index})"><i data-lucide="trash-2"></i></button>
                    </div>
                </div>
            </div>
        `).join('');
        
        lucide.createIcons();
    }
}

window.addToCartFromStore = function(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;
    
    const weightSelect = document.getElementById(`weight-${productId}`);
    const selectedWeight = weightSelect ? weightSelect.value : product.weights[0];
    
    // Calculate price based on selected weight index
    const weightIndex = product.weights.indexOf(selectedWeight);
    let multiplier = 1;
    if (weightIndex === 1) multiplier = 1.8;
    if (weightIndex === 2) multiplier = 3.2;
    const finalPrice = Math.round(getPrice(product) * multiplier);
    
    addItemToCart(product, selectedWeight, finalPrice, 1);
    showCartDrawer();
};

window.buyNowFromStore = function(productId) {
    addToCartFromStore(productId);
    showCartDrawer();
};

window.addDetailsToCart = function(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;
    
    const activeChip = document.querySelector('.weight-chip.active');
    const selectedWeight = activeChip ? activeChip.getAttribute('data-weight') : product.weights[0];
    const qtyVal = document.getElementById('details-qty-val');
    const quantity = qtyVal ? parseInt(qtyVal.textContent) : 1;
    
    const weightIndex = product.weights.indexOf(selectedWeight);
    let multiplier = 1;
    if (weightIndex === 1) multiplier = 1.8;
    if (weightIndex === 2) multiplier = 3.2;
    const finalPrice = Math.round(getPrice(product) * multiplier);
    
    addItemToCart(product, selectedWeight, finalPrice, quantity);
    showCartDrawer();
};

window.buyDetailsNow = function(productId) {
    addDetailsToCart(productId);
    showCartDrawer();
};

function addItemToCart(product, weight, price, qty) {
    // Check if duplicate exists
    const duplicateIndex = cart.findIndex(item => item.product.id === product.id && item.weight === weight);
    
    if (duplicateIndex > -1) {
        cart[duplicateIndex].quantity += qty;
    } else {
        cart.push({
            product: product,
            weight: weight,
            price: price,
            quantity: qty
        });
    }
    updateCartUI();
}

window.updateCartItemQty = function(index, change) {
    cart[index].quantity += change;
    if (cart[index].quantity < 1) {
        cart.splice(index, 1);
    }
    updateCartUI();
};

window.removeCartItem = function(index) {
    cart.splice(index, 1);
    updateCartUI();
};

function showCartDrawer() {
    const overlay = document.getElementById('cart-drawer-overlay');
    const drawer = document.getElementById('cart-drawer');
    if (overlay && drawer) {
        overlay.classList.add('open');
        drawer.classList.add('open');
    }
}

function closeCartDrawer() {
    const overlay = document.getElementById('cart-drawer-overlay');
    const drawer = document.getElementById('cart-drawer');
    if (overlay && drawer) {
        overlay.classList.remove('open');
        drawer.classList.remove('open');
    }
}

// 10. Reviews Testimonial Slider System
function rotateTestimonials(direction) {
    const track = document.getElementById('testimonial-track');
    if (!track) return;
    
    const cards = track.querySelectorAll('.testimonial-card');
    if (cards.length === 0) return;
    
    cards[activeTestimonialIndex].classList.remove('active');
    
    activeTestimonialIndex += direction;
    if (activeTestimonialIndex >= cards.length) {
        activeTestimonialIndex = 0;
    } else if (activeTestimonialIndex < 0) {
        activeTestimonialIndex = cards.length - 1;
    }
    
    cards[activeTestimonialIndex].classList.add('active');
    
    // Slide transition
    const offset = -100 * activeTestimonialIndex;
    track.style.transform = `translateX(${offset}%)`;
}

// Helper: category route navigation
window.filterStorefrontAndNavigate = function(categoryId) {
    window.location.hash = '#products';
    
    // Set active filter chip inside products sidebar
    setTimeout(() => {
        const filterChips = document.querySelectorAll('.filter-chip');
        filterChips.forEach(chip => {
            if (chip.getAttribute('data-category') === categoryId) {
                chip.click();
            }
        });
    }, 100);
};

// 11. Modal Trigger Dialogs
function showModal(title, contentHTML) {
    const overlay = document.getElementById('global-modal-overlay');
    const modal = document.getElementById('global-modal');
    const titleEl = document.getElementById('modal-title');
    const bodyEl = document.getElementById('modal-body');
    
    if (overlay && modal && titleEl && bodyEl) {
        titleEl.textContent = title;
        bodyEl.innerHTML = contentHTML;
        
        overlay.classList.add('open');
        modal.classList.add('open');
    }
}

function closeModal() {
    const overlay = document.getElementById('global-modal-overlay');
    const modal = document.getElementById('global-modal');
    if (overlay && modal) {
        overlay.classList.remove('open');
        modal.classList.remove('open');
    }
}

// 12. Setup event listeners
function registerUIEventListeners() {
    // Scroll Header Scroll class & Scroll-To-Top button visibility
    const header = document.querySelector('.navbar-header');
    const scrollTopBtn = document.getElementById('scroll-to-top-btn');
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 40) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
        
        if (window.scrollY > 500) {
            if (scrollTopBtn) scrollTopBtn.style.display = 'flex';
        } else {
            if (scrollTopBtn) scrollTopBtn.style.display = 'none';
        }
    });
    
    if (scrollTopBtn) {
        scrollTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }
    
    // Hamburger menu toggle
    const hamburger = document.getElementById('hamburger-menu');
    const navMenu = document.getElementById('nav-menu');
    if (hamburger && navMenu) {
        hamburger.addEventListener('click', () => {
            navMenu.classList.toggle('open');
        });
    }
    
    // Search Drawer open/close triggers
    const searchTrigger = document.getElementById('search-trigger');
    const searchDrawer = document.getElementById('search-drawer');
    const searchClose = document.getElementById('search-close');
    const searchInput = document.getElementById('search-input');
    
    if (searchTrigger && searchDrawer && searchClose) {
        searchTrigger.addEventListener('click', () => {
            searchDrawer.classList.toggle('open');
            if (searchDrawer.classList.contains('open') && searchInput) {
                searchInput.focus();
            }
        });
        
        searchClose.addEventListener('click', () => {
            searchDrawer.classList.remove('open');
        });
    }
    
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            const query = e.target.value;
            // switch to products view if user is typing
            if (window.location.hash !== '#products') {
                window.location.hash = '#products';
            }
            injectStorefrontProducts('all', query);
        });
    }
    
    // Sort Select listener
    const sortSelect = document.getElementById('sort-select');
    if (sortSelect) {
        sortSelect.addEventListener('change', () => {
            // Find active filter chip to maintain category scope
            const activeChip = document.querySelector('.filter-chip.active');
            const category = activeChip ? activeChip.getAttribute('data-category') : 'all';
            injectStorefrontProducts(category, searchInput?.value || '');
        });
    }
    
    // Cart drawer toggle
    const cartTrigger = document.getElementById('cart-trigger');
    const closeCartBtn = document.getElementById('close-cart-btn');
    const cartOverlay = document.getElementById('cart-drawer-overlay');
    
    if (cartTrigger) {
        cartTrigger.addEventListener('click', showCartDrawer);
    }
    if (closeCartBtn) {
        closeCartBtn.addEventListener('click', closeCartDrawer);
    }
    if (cartOverlay) {
        cartOverlay.addEventListener('click', closeCartDrawer);
    }
    
    // "Shop Now" in empty cart redirect
    const emptyCartBtn = document.querySelector('.shop-now-btn');
    if (emptyCartBtn) {
        emptyCartBtn.addEventListener('click', () => {
            closeCartDrawer();
            window.location.hash = '#products';
        });
    }
    
    // Clear Cart button
    const clearCartBtn = document.getElementById('clear-cart-btn');
    if (clearCartBtn) {
        clearCartBtn.addEventListener('click', () => {
            cart = [];
            updateCartUI();
        });
    }
    
    // Checkout trigger
    const checkoutBtn = document.getElementById('checkout-btn');
    if (checkoutBtn) {
        checkoutBtn.addEventListener('click', () => {
            closeCartDrawer();
            const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            
            showModal(
                'Sea Whale Checkout Simulation',
                `
                <div class="text-center">
                    <i data-lucide="check-circle" style="color: var(--success); width: 48px; height: 48px; margin: 0 auto 16px auto;"></i>
                    <p class="mb-3"><strong>Subtotal: ₹${subtotal.toLocaleString('en-IN')}</strong></p>
                    <p class="text-muted text-sm">Thank you for evaluating this premium UI showcase. The cart data would now be dispatched to an integrated payment vault or commercial cold chain scheduling service.</p>
                </div>
                `
            );
            
            // clear cart upon simulated checkouts
            cart = [];
            updateCartUI();
        });
    }
    
    // Testimonial sliders
    const prevTestiBtn = document.getElementById('prev-testi-btn');
    const nextTestiBtn = document.getElementById('next-testi-btn');
    
    if (prevTestiBtn) prevTestiBtn.addEventListener('click', () => rotateTestimonials(-1));
    if (nextTestiBtn) nextTestiBtn.addEventListener('click', () => rotateTestimonials(1));
    
    // Auto rotation every 8 seconds
    setInterval(() => {
        rotateTestimonials(1);
    }, 8000);
    
    // Forms validation and submission traps
    const preorderForm = document.getElementById('preorder-form');
    if (preorderForm) {
        preorderForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const name = document.getElementById('po-name').value;
            const product = document.getElementById('po-product').value;
            const qty = document.getElementById('po-qty').value;
            const date = document.getElementById('po-date').value;
            const time = document.getElementById('po-time').value;
            
            showModal(
                'Pre-Order Booked Successfully',
                `
                <div>
                    <p class="mb-3">Dear <strong>${name}</strong>, your pre-order request has been securely queued in the Sea Whale harbor scheduler.</p>
                    <table style="width:100%; font-size:0.9rem; border-collapse:collapse; margin-top:12px;">
                        <tr style="border-bottom:1px solid rgba(0,0,0,0.05);"><td style="padding:6px 0; font-weight:600;">Product:</td><td style="padding:6px 0;">${product}</td></tr>
                        <tr style="border-bottom:1px solid rgba(0,0,0,0.05);"><td style="padding:6px 0; font-weight:600;">Quantity:</td><td style="padding:6px 0;">${qty} Pack(s)</td></tr>
                        <tr style="border-bottom:1px solid rgba(0,0,0,0.05);"><td style="padding:6px 0; font-weight:600;">Delivery Window:</td><td style="padding:6px 0;">${date} | ${time}</td></tr>
                    </table>
                    <p class="mt-4 text-muted" style="font-size:0.8rem;">Our port sourcing supervisor will reach out on your mobile number to coordinate vessel berthing confirmations and logistics checkpoints.</p>
                </div>
                `
            );
            preorderForm.reset();
        });
    }
    
    const bulkForm = document.getElementById('bulk-form');
    if (bulkForm) {
        bulkForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const company = document.getElementById('bulk-business').value;
            const person = document.getElementById('bulk-person').value;
            const qty = document.getElementById('bulk-qty').value;
            
            showModal(
                'Commercial Enquiry Logged',
                `
                <div>
                    <p class="mb-3">Thank you, <strong>${person}</strong>. A dedicated wholesale relationship manager has been assigned to your corporate account.</p>
                    <p><strong>Business Unit:</strong> ${company}</p>
                    <p><strong>Proposed Monthly Volume:</strong> ${qty} Kg</p>
                    <p class="mt-3 text-muted" style="font-size:0.8rem;">We will transmit customized contract pricing tables and cold chain transport scheduling specifications to your registered email address within 2 working hours.</p>
                </div>
                `
            );
            bulkForm.reset();
        });
    }
    
    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const name = document.getElementById('c-name').value;
            
            showModal(
                'Message Dispatched',
                `
                <div>
                    <p>Hello <strong>${name}</strong>, your secure direct inquiry has been transmitted to our Sea Whale Visakhapatnam support desk. We will respond shortly.</p>
                </div>
                `
            );
            contactForm.reset();
        });
    }
    
    const newsletterForm = document.getElementById('newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', (e) => {
            e.preventDefault();
            showModal(
                'Newsletter Subscribed',
                `<p>Your email has been subscribed to the Sea Whale Sub-Zero Sourcing Bulletin. You will receive real-time notifications about incoming fishing harvests.</p>`
            );
            newsletterForm.reset();
        });
    }
    
    // FAQ Accordion clicks
    const faqQuestions = document.querySelectorAll('.faq-question');
    faqQuestions.forEach(q => {
        q.addEventListener('click', () => {
            const faqItem = q.parentElement;
            
            // Toggle open class
            faqItem.classList.toggle('open');
        });
    });
    
    // Modal buttons closure triggers
    const closeModalBtn = document.getElementById('close-modal-btn');
    const modalConfirmBtn = document.getElementById('modal-confirm-btn');
    const modalOverlay = document.getElementById('global-modal-overlay');
    
    if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
    if (modalConfirmBtn) modalConfirmBtn.addEventListener('click', closeModal);
    if (modalOverlay) modalOverlay.addEventListener('click', closeModal);
    
    // Buy Feast Combo on home page
    const homeComboBuyBtn = document.getElementById('home-combo-buy-btn');
    if (homeComboBuyBtn) {
        homeComboBuyBtn.addEventListener('click', () => {
            // Find seafood combo item or add standard feast combo to cart
            const comboProd = products.find(p => p.id === 'black-tiger-prawns'); // fallback
            if (comboProd) {
                addItemToCart(comboProd, 'Gourmet Feast Combo Pack', 2199, 1);
                showCartDrawer();
            }
        });
    }
    
    // Countdown Timer animation on Offers Page
    initOffersCountdown();
}

function initOffersCountdown() {
    let days = 0;
    let hours = 8;
    let minutes = 42;
    let seconds = 19;
    
    const daysEl = document.getElementById('days');
    const hoursEl = document.getElementById('hours');
    const minsEl = document.getElementById('minutes');
    const secsEl = document.getElementById('seconds');
    
    if (!secsEl) return;
    
    setInterval(() => {
        seconds--;
        if (seconds < 0) {
            seconds = 59;
            minutes--;
            if (minutes < 0) {
                minutes = 59;
                hours--;
                if (hours < 0) {
                    hours = 23;
                    days--;
                    if (days < 0) {
                        // Reset to mock values to prevent stopping
                        days = 1;
                        hours = 12;
                        minutes = 0;
                        seconds = 0;
                    }
                }
            }
        }
        
        if (daysEl) daysEl.textContent = String(days).padStart(2, '0');
        if (hoursEl) hoursEl.textContent = String(hours).padStart(2, '0');
        if (minsEl) minsEl.textContent = String(minutes).padStart(2, '0');
        if (secsEl) secsEl.textContent = String(seconds).padStart(2, '0');
    }, 1000);
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final String name;
  final String category;
  final double price;
  final String? imageUrl;
  final IconData icon;

  Product({
    required this.name,
    required this.category,
    required this.price,
    this.imageUrl,
    required this.icon,
  });
}

// Ürün verilerini burada tanımladım, gerçekte API'dan çekilebilir
List<Product> products = [
  Product(
    name: 'iPhone',
    category: 'Telefon',
    price: 999,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/IPhone_7_black.png/220px-IPhone_7_black.png',
    icon: Icons.smartphone,
  ),
  Product(
    name: 'MacBook Air',
    category: 'Laptop',
    price: 1299,
    imageUrl:
        'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbook-air-midnight-select-20220606?wid=400&hei=400&fmt=png-alpha',
    icon: Icons.laptop_mac,
  ),
  Product(
    name: 'iPad Air',
    category: 'Tablet',
    price: 599,
    imageUrl:
        'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-air-select-wifi-blue-202203?wid=400&hei=400&fmt=png-alpha',
    icon: Icons.tablet_mac,
  ),
  Product(
    name: 'AirPods Pro',
    category: 'Aksesuar',
    price: 249,
    imageUrl:
        'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=400&hei=400&fmt=png-alpha',
    icon: Icons.headphones,
  ),
  Product(
    name: 'Apple Watch',
    category: 'Saat',
    price: 399,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Apple_Watch_Series_7.png/220px-Apple_Watch_Series_7.png',
    icon: Icons.watch,
  ),
  Product(
    name: 'HomePod Mini',
    category: 'Hoparlör',
    price: 99,
    imageUrl:
        'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/homepod-mini-select-yellow-202110?wid=400&hei=400&fmt=png-alpha',
    icon: Icons.speaker,
  ),
];

// Sepet listesi
List<Product> cart = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF1C1C1E),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFF007AFF),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFD1D1D6), height: 0.5),
        ),
      ),
      // GridView ile kart tabanlı bir liste yaptım
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Karta tıklayınca detay sayfasına geçiyor
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(product: product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                height: 100,
                width: double.infinity,
                color: const Color(0xFFF2F2F7),
                child: product.imageUrl != null
                    ? Image.network(
                        product.imageUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          product.icon,
                          size: 44,
                          color: const Color(0xFF1C1C1E),
                        ),
                      )
                    : Icon(
                        product.icon,
                        size: 44,
                        color: const Color(0xFF1C1C1E),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.category,
                    style: const TextStyle(
                      color: Color(0xFF8E8E93),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      color: Color(0xFF007AFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
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

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool inCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
            color: Color(0xFF1C1C1E),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF007AFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFD1D1D6), height: 0.5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: widget.product.imageUrl != null
                  ? Image.network(
                      widget.product.imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        widget.product.icon,
                        size: 80,
                        color: const Color(0xFF1C1C1E),
                      ),
                    )
                  : Icon(
                      widget.product.icon,
                      size: 80,
                      color: const Color(0xFF1C1C1E),
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1E),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.product.category,
              style: const TextStyle(fontSize: 15, color: Color(0xFF8E8E93)),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFF007AFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            // Sepete ekleyip çıkarma için state kullandım
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (inCart) {
                      cart.remove(widget.product);
                    } else {
                      cart.add(widget.product);
                    }
                    inCart = !inCart;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: inCart
                      ? Colors.red
                      : const Color(0xFF007AFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  inCart ? 'Sepetten Çıkar' : 'Sepete Ekle',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sepetim',
          style: TextStyle(
            color: Color(0xFF1C1C1E),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF007AFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFD1D1D6), height: 0.5),
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Color(0xFF8E8E93),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sepetiniz boş',
                    style: TextStyle(fontSize: 18, color: Color(0xFF8E8E93)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 36,
                              color: const Color(0xFF1C1C1E),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    item.category,
                                    style: const TextStyle(
                                      color: Color(0xFF8E8E93),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${item.price}',
                              style: const TextStyle(
                                color: Color(0xFF007AFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFD1D1D6), width: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Toplam',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$$total',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007AFF),
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

import 'package:flutter/material.dart';
import 'package:oruphone/models/product_model.dart';
import 'package:oruphone/services/product_services.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  bool isLoading = true;
  Map<String, dynamic> filters = {};

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => isLoading = true);
    try {
      final result = await ProductService.fetchProducts(filters);
      setState(() => products = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading products: $e'),
          duration: Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildFilterControls() {
    return Column(
      children: [
        // Keep your existing filter controls
        // ...
      ],
    );
  }

  Widget _buildProductGrid() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 50, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Products Found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadProducts,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  product.imagePath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 50),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.marketingName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('₹${product.listingPrice}',
                        style: TextStyle(color: Colors.green[800])),
                    SizedBox(height: 4),
                    Text('Condition: ${product.deviceCondition}',
                        style: TextStyle(fontSize: 12)),
                    Text('Storage: ${product.deviceStorage}',
                        style: TextStyle(fontSize: 12)),
                    if (product.verified)
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Icon(Icons.verified, color: Colors.blue, size: 16),
                            SizedBox(width: 4),
                            Text('Verified',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: _buildFilterControls(),
            ),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }
}

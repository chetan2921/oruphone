import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:last_try/models/product_model.dart';

class ProductService {
  static Future<List<Product>> fetchProducts(
      Map<String, dynamic> filters) async {
    try {
      final response = await http.post(
        Uri.parse('http://40.90.224.241:5000/filter'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'filter': filters}),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data']['data'] != null) {
          List products = data['data']['data'];
          return products.map((json) => Product.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products');
    }
  }
}

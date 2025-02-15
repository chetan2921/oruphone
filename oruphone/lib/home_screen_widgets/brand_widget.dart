import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrandsDisplayPage extends StatefulWidget {
  const BrandsDisplayPage({super.key});

  @override
  State<BrandsDisplayPage> createState() => _BrandsDisplayPageState();
}

class _BrandsDisplayPageState extends State<BrandsDisplayPage> {
  List<dynamic> _brands = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  Future<void> _fetchBrands() async {
    try {
      final response = await http.get(Uri.parse(
          'http://40.90.224.241:5000/makeWithImages')); // Replace with your actual API endpoint

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'SUCCESS') {
          setState(() {
            _brands = data['dataObject'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch brands')),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : _buildBrandsList(), // Show the list of brands
    );
  }

  Widget _buildBrandsList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Horizontal scrolling
      padding: const EdgeInsets.all(16),
      itemCount: _brands.length,
      itemBuilder: (context, index) {
        final brand = _brands[index];
        return _buildBrandCard(brand);
      },
    );
  }

  Widget _buildBrandCard(Map<String, dynamic> brand) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        color: const Color.fromARGB(255, 237, 237, 237),
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              brand['imagePath'],
              width: 23,
              height: 23,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 23);
              },
            ),
            const SizedBox(height: 8),
            Text(
              brand['make'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

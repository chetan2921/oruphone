import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FilterButtonExample extends StatefulWidget {
  const FilterButtonExample({super.key});

  @override
  State<FilterButtonExample> createState() => _FilterButtonExampleState();
}

class _FilterButtonExampleState extends State<FilterButtonExample> {
  Map<String, dynamic>? filters;
  bool isLoading = false;

  // Track selected filters
  Map<String, List<String>> selectedFilters = {
    'Brand': [],
    'Ram': [],
    'Storage': [],
    'Conditions': [],
    'Warranty': [],
  };

  Future<void> fetchFilters() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('http://40.90.224.241:5000/showSearchFilters'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        filters = data['dataObject'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load filters');
    }
  }

  void _showFilterDialog() {
    if (filters == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set dialog background to white
          title: const Text('Filter Options'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFilterSection('Brand', filters!['Brand']),
                _buildFilterSection('Ram', filters!['Ram']),
                _buildFilterSection('Storage', filters!['Storage']),
                _buildFilterSection('Conditions', filters!['Conditions']),
                _buildFilterSection('Warranty', filters!['Warranty']),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _resetFilters(); // Reset all selected filters
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
            TextButton(
              onPressed: () {
                _applyFilters(); // Apply selected filters
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterSection(String title, List<dynamic> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            return FilterChip(
              label: Text(option.toString()),
              selected: selectedFilters[title]!.contains(option.toString()),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedFilters[title]!.add(option.toString());
                  } else {
                    selectedFilters[title]!.remove(option.toString());
                  }
                });
              },
              backgroundColor:
                  Colors.white, // Set unselected chip background to white
              selectedColor: Colors
                  .blue[100], // Set selected chip background to light blue
              checkmarkColor: Colors.blue, // Set checkmark color to blue
              labelStyle: TextStyle(
                color: selectedFilters[title]!.contains(option.toString())
                    ? Colors.blue // Selected text color
                    : Colors.black, // Unselected text color
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _applyFilters() {
    // Logic to apply selected filters
    print('Applied Filters: $selectedFilters');
    // You can pass the selected filters to another function or update the UI
  }

  void _resetFilters() {
    // Reset all selected filters
    setState(() {
      selectedFilters.forEach((key, value) {
        selectedFilters[key]!.clear();
      });
    });
    print('Filters Reset');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await fetchFilters();
            _showFilterDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color.fromARGB(255, 224, 229, 229), // Background color
            foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12), // Padding
          ),
          child: const Text('Show Filters'),
        ),
      ),
    );
  }
}

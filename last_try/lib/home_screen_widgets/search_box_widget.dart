import 'package:flutter/material.dart';

class SearchBoxExample extends StatelessWidget {
  const SearchBoxExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search phones with make, model, company', // Hint text
              prefixIcon: const Icon(Icons.search), // Search icon
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              filled: true, // Enable filling the background
              fillColor: const Color.fromARGB(
                  255, 255, 255, 255), // Light grey background
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: 16.0), // Padding inside the box
            ),
            onChanged: (value) {
              // Handle search input changes
              print('Search query: $value');
            },
          ),
        ),
      ),
    );
  }
}

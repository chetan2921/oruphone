import 'package:flutter/material.dart';

class ScrollableTextRow extends StatelessWidget {
  const ScrollableTextRow({super.key});

  @override
  Widget build(BuildContext context) {
    // List of custom text for each container
    final List<String> customTexts = [
      'Nearby Deals',
      'Deals in 250 km',
      'Verified Deals',
      'Deals in 50 km',
      'Apple',
      'Samsung',
      'Under Waranty',
      'Refurbished',
      'Like New',
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: customTexts.length,
      itemBuilder: (context, index) {
        return _buildContainer(customTexts[index]);
      },
    );
  }

  Widget _buildContainer(String text) {
    return Container(
      width: 100, // Width of each container
      height: 40, // Height of each container
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromARGB(255, 240, 240, 240)),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

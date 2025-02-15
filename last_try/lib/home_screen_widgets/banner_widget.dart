import 'package:flutter/material.dart';

class BannerCarouselPage extends StatelessWidget {
  final List<String> bannerImages = [
    'assets/images/Property 1=Banner 1.png',
    'assets/images/Property 1=Banner 2.png',
    'assets/images/Property 1=Banner 3.png',
    'assets/images/Property 1=Banner 4.png',
    'assets/images/Property 1=Banner 5.png',
  ];

  BannerCarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bannerImages.length,
      itemBuilder: (context, index) {
        return _buildBanner(bannerImages[index]);
      },
    );
  }

  Widget _buildBanner(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

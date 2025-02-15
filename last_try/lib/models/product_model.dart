class Product {
  final String id;
  final String make;
  final String marketingName;
  final String listingPrice;
  final String deviceCondition;
  final String deviceStorage;
  final String imagePath;
  final bool verified;

  Product({
    required this.id,
    required this.make,
    required this.marketingName,
    required this.listingPrice,
    required this.deviceCondition,
    required this.deviceStorage,
    required this.imagePath,
    required this.verified,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      make: json['make'] ?? 'Unknown Brand',
      marketingName: json['marketingName'] ?? 'Unnamed Product',
      listingPrice: json['listingPrice']?.toString() ?? '0',
      deviceCondition: json['deviceCondition'] ?? 'Condition Unknown',
      deviceStorage: json['deviceStorage'] ?? 'Storage Unknown',
      imagePath: json['imagePath'] ?? 'https://via.placeholder.com/150',
      verified: json['verified'] ?? false,
    );
  }
}

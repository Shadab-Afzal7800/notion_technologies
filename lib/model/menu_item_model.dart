class MenuItem {
  final int id;
  final String name;
  final String description;
  final String hotelName;
  final String foodType;
  final String foodCategory;
  final double rating;
  final String image;
  final PriceDetails priceDetails;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.hotelName,
    required this.foodType,
    required this.foodCategory,
    required this.rating,
    required this.image,
    required this.priceDetails,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      hotelName: json['hotel_name'],
      foodType: json['food_type'],
      foodCategory: json['food_category_name'],
      rating: (json['rating'] as num).toDouble(),
      image: json['image'] ?? '',
      priceDetails: PriceDetails.fromJson(json),
    );
  }
}

class PriceDetails {
  final double originalPrice;
  final double discountedPrice;

  PriceDetails({
    required this.originalPrice,
    required this.discountedPrice,
  });

  factory PriceDetails.fromJson(Map<String, dynamic> json) {
    if (json['size_type'] == 'Multi-size') {
      return PriceDetails(
        originalPrice: (json['regular_original_price'] as num).toDouble(),
        discountedPrice: (json['regular_discounted_price'] as num).toDouble(),
      );
    }
    return PriceDetails(
      originalPrice: (json['original_price'] as num).toDouble(),
      discountedPrice: (json['discounted_price'] as num).toDouble(),
    );
  }
}

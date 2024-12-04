class CartItem {
  final int id;
  final int menuId;
  final String menuName;
  final String menuImage;
  final double menuPrice;
  final int quantity;
  final String hotelName;

  CartItem({
    required this.id,
    required this.menuId,
    required this.menuName,
    required this.menuImage,
    required this.menuPrice,
    required this.quantity,
    required this.hotelName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      menuId: json['menu_id'],
      menuName: json['menu_name'],
      menuImage: json['menu_image'],
      menuPrice: double.parse(json['menu_price'].toString()),
      quantity: json['quantity'],
      hotelName: json['hotel_name'],
    );
  }
}

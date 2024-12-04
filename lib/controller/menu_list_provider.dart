import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notion_technologies_task/constants/api_endpoints.dart';
import 'package:notion_technologies_task/model/menu_item_model.dart';

class MenuProvider with ChangeNotifier {
  List<MenuItem> _menuItems = [];
  List<MenuItem> _originalMenuItems = [];
  bool _isLoading = false;
  String _error = '';

  int _customerId = 1115;
  final int _partnerId = 15;

  List<MenuItem> get menuItems => _menuItems;
  bool get isLoading => _isLoading;
  String get error => _error;

  bool _isVegFilter = false;
  bool _isNonVegFilter = false;
  bool _sortLowToHigh = false;

  bool get isVegFilter => _isVegFilter;
  bool get isNonVegFilter => _isNonVegFilter;
  bool get sortLowToHigh => _sortLowToHigh;

  Future<void> fetchMenuItems(int customerId, int hotelId) async {
    _isLoading = true;
    _error = '';
    _customerId = customerId;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiEndpoints.getMenuItems}?customer_id=$customerId&hotel_id=$hotelId',
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _originalMenuItems = (jsonData['data'] as List)
            .map((item) => MenuItem.fromJson(item))
            .toList();
        _menuItems = List.from(_originalMenuItems);
      } else {
        _error = 'Failed to load menu items';
      }
    } catch (e) {
      _error = 'An error occurred: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToCart({
    required int menuId,
    int quantity = 1,
    String size = 'standard',
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ApiEndpoints.addToCart}?'
          'menu_id=$menuId&'
          'customer_id=$_customerId&'
          'partner_id=$_partnerId&'
          'quantity=$quantity&'
          'size=$size&'
          'amount=${_getDiscountedPrice(menuId)}',
        ),
      );

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final jsonResponse = json.decode(response.body);

        return true;
      } else {
        _error = 'Failed to add item to cart';
        return false;
      }
    } catch (e) {
      _error = 'An error occurred while adding to cart: ${e.toString()}';
      return false;
    }
  }

  double _getDiscountedPrice(int menuId) {
    final item = _menuItems.firstWhere((item) => item.id == menuId);
    return item.priceDetails.discountedPrice;
  }

  void toggleVegFilter() {
    _isVegFilter = !_isVegFilter;
    _isNonVegFilter = false;
    _applyFiltersAndSort();
  }

  void toggleNonVegFilter() {
    _isNonVegFilter = !_isNonVegFilter;
    _isVegFilter = false;
    _applyFiltersAndSort();
  }

  void toggleSorting() {
    _sortLowToHigh = !_sortLowToHigh;
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    _menuItems = List.from(_originalMenuItems);

    if (_isVegFilter) {
      _menuItems = _menuItems.where((item) => item.foodType == 'Veg').toList();
    } else if (_isNonVegFilter) {
      _menuItems =
          _menuItems.where((item) => item.foodType == 'Non-veg').toList();
    }

    _menuItems.sort((a, b) => _sortLowToHigh
        ? a.priceDetails.discountedPrice
            .compareTo(b.priceDetails.discountedPrice)
        : b.priceDetails.discountedPrice
            .compareTo(a.priceDetails.discountedPrice));

    notifyListeners();
  }
}

// menu_provider.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notion_technologies_task/model/menu_item_model.dart';

class MenuProvider with ChangeNotifier {
  List<MenuItem> _menuItems = [];
  List<MenuItem> _originalMenuItems = [];
  bool _isLoading = false;
  String _error = '';

  List<MenuItem> get menuItems => _menuItems;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Filtering and sorting variables
  bool _isVegFilter = false;
  bool _isNonVegFilter = false;
  bool _sortLowToHigh = false;

  bool get isVegFilter => _isVegFilter;
  bool get isNonVegFilter => _isNonVegFilter;
  bool get sortLowToHigh => _sortLowToHigh;

  Future<void> fetchMenuItems(int customerId, int hotelId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          'https://thealaddin.in/mmApi/api/show/menu-list?customer_id=$customerId&hotel_id=$hotelId',
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
    // Reset to original items first
    _menuItems = List.from(_originalMenuItems);

    // Apply food type filter
    if (_isVegFilter) {
      _menuItems = _menuItems.where((item) => item.foodType == 'Veg').toList();
    } else if (_isNonVegFilter) {
      _menuItems =
          _menuItems.where((item) => item.foodType == 'Non-veg').toList();
    }

    // Apply sorting
    _menuItems.sort((a, b) => _sortLowToHigh
        ? a.priceDetails.discountedPrice
            .compareTo(b.priceDetails.discountedPrice)
        : b.priceDetails.discountedPrice
            .compareTo(a.priceDetails.discountedPrice));

    notifyListeners();
  }
}

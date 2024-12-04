import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notion_technologies_task/constants/api_endpoints.dart';
import 'package:notion_technologies_task/model/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  bool _isLoading = false;
  int? _loadingCartId;
  String? _error;

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  int? get loadingCartId => _loadingCartId;
  String? get error => _error;

  Future<void> fetchCartItems(String customerId) async {
    _isLoading = true;
    _loadingCartId = null;
    _error = null;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getCartItems}?customer_id=$customerId'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _cartItems = (responseData['data'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      } else {
        _error = 'Cart Empty';
      }
    } catch (e) {
      print("An error occurred: ${e.toString()}");
      _error = 'An error occurred: ${e.toString()}';
    } finally {
      _isLoading = false;
      _loadingCartId = null;
      notifyListeners();
    }
  }

  Future<void> updateCartItemQuantity(int cartId, bool isAdding) async {
    _loadingCartId = cartId;
    _error = null;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(
          '${ApiEndpoints.updateCartQuantity}?'
          'cart_id=$cartId&status=${isAdding ? 'Add' : 'Remove'}',
        ),
      );
      if (response.statusCode == 200) {
        log(response.body);
        await fetchCartItems('1115');
      } else {
        _error = 'Failed to update cart item quantity';
      }
    } catch (e) {
      _error = 'An error occurred: ${e.toString()}';
    } finally {
      _loadingCartId = null;
      notifyListeners();
    }
  }

  double get totalAmount {
    return _cartItems.fold(
        0, (total, item) => total + (item.menuPrice * item.quantity));
  }
}

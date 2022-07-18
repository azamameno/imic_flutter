import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get getItems {
    return _items;
  }

  int get count {
    int sum = 0;
    if (_items.isNotEmpty) {
      _items.forEach((_, value) {
        sum += value;
      });
    }

    return sum;
  }

  bool hasItem(String productId) => _items.containsKey(productId);

  void setItem(String productId, int quantity) {
    if (quantity == 0) {
      removeItem(productId);
      return;
    }

    _items.update(
      productId,
      (value) => value += quantity,
      ifAbsent: () => quantity,
    );
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}

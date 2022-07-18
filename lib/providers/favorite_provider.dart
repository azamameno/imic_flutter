import 'dart:collection';

import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final productIds = HashSet<String>();

  bool has(String productId) => productIds.contains(productId);

  void set(String productId) {
    if (has(productId)) {
      productIds.remove(productId);
    } else {
      productIds.add(productId);
    }
    notifyListeners();
  }
}

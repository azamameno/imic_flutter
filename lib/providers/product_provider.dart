import 'package:flutter/material.dart';
import 'package:imic_flutter/models/product.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final _uuid = const Uuid();
  final List<Product> _products = [];

  ProductProvider() {
    _products.add(Product(
      id: _uuid.v1(),
      title: 'Demo',
      price: 100,
      description: 'This is demo product',
      imageUrl:
          'https://dongphuccaocap.vn/wp-content/uploads/2017/05/ao-thun-qua-tang-1.jpg',
    ));

    _products.add(Product(
      id: _uuid.v1(),
      title: 'product 2',
      price: 80,
      description: 'This is product 2',
      imageUrl:
          'https://dongphuccaocap.vn/wp-content/uploads/2017/10/ao-thun-co-co-1.jpg',
    ));

    _products.add(Product(
      id: _uuid.v1(),
      title: 'Ao thun',
      price: 50,
      description: 'Ao thun',
      imageUrl:
          'https://dongphuccaocap.vn/wp-content/uploads/2018/08/dong-phuc-cong-so-may-do-1.jpg',
    ));
  }

  List<Product> get getProducts {
    return _products;
  }
}

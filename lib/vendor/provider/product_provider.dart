import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  getFormData({
    String? menuName,
    double? menuPrice,
    String? description,
    String? categories,
    List<String>? imageUrlList,
    int? quantity,
    int? menuQuantity,
  }) {
    if (menuName != null) {
      productData['menuName'] = menuName;
    }
    if (menuPrice != null) {
      productData['menuPrice'] = menuPrice;
    }
    if (categories != null) {
      productData['categories'] = categories;
    }
    if (description != null) {
      productData['description'] = description;
    }
    if (imageUrlList != null) {
      productData['imageUrlList'] = imageUrlList;
    }
    notifyListeners();
  }

  clearData() {
    productData.clear();
    notifyListeners();
  }
}

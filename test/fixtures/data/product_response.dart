import 'package:flutter_project/shared/globals.dart';

Map<String, dynamic> productListMap({int? skip}) => {
      "products": List.generate(PRODUCTS_PER_PAGE, (index) => productMap),
      "total": 100,
      "skip": (skip ?? 0) + PRODUCTS_PER_PAGE,
      "limit": PRODUCTS_PER_PAGE,
    };
Map<String, dynamic> productMap = {
  "id": 1,
  "title": "iPhone 9",
  "description": "An apple mobile which is nothing like apple",
  "price": 549,
  "discountPercentage": 12.96,
  "rating": 4.69,
  "stock": 94,
  "brand": "Apple",
  "category": "smartphones",
  "thumbnail": "...",
  "images": ["...", "...", "..."]
};

import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_project/shared/domain/models/parse_response.dart';
import 'package:flutter_project/shared/domain/models/product/product_model.dart';

import '../data/product_response.dart';

Map<String, dynamic> ktestProductResponse = productListMap();

PaginatedResponse ktestPaginatedResponse({int? skip}) =>
    PaginatedResponse.fromJson(
        productListMap(skip: skip), productListMap(skip: skip)['products']);

final ktestParseResponse = ktestPaginatedResponse().data.map(
      (e) => ParseResponse<Product>.fromMap(e, modifier: Product.fromJson),
    );
final List<Product> ktestProductList = (productListMap()['products'] as List)
    .map((e) => Product.fromJson(e))
    .toList();

final ktestProduct = Product.fromJson({});

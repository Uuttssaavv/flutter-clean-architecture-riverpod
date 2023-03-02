import 'package:flutter_project/shared/domain/models/parse_response.dart';
import 'package:flutter_project/shared/domain/models/product/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/data/product_response.dart';

void main() {
  test('Should parse response in correct format', () {
    final response = ParseResponse<Product>.fromMap(productListMap(),
        modifier: Product.fromJson);

    expect(response.data is Product, true);
  });
}

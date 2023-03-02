import 'package:flutter_project/shared/domain/models/product/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/dashboard/dummy_productlist.dart';
import '../../../../fixtures/data/product_response.dart';

void main() {
  group(
    'ProductModel Test\n',
    () {
      test('Should parse Product from json', () {
        expect(Product.fromJson(productMap), ktestProductList[0]);
      });

      test('Should return json from product', () {
        expect(ktestProductList[0].toJson(), productMap);
      });
      test('Should return string of user', () {
        expect(ktestProductList[0].toJson(), isA<Map<String, dynamic>>());
      });
    },
  );
}

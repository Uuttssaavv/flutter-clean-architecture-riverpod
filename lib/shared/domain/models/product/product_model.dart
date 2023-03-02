import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

typedef ProductList = List<Product>;

@freezed
class Product with _$Product {
  factory Product({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String thumbnail,
    @Default('') String brand,
    @Default('') String category,
    @Default(0.0) double rating,
    @Default(0.0) double discountPercentage,
    @Default(0) int stock,
    @Default(0) int price,
    @Default([]) List<String> images,
  }) = _Product;

  factory Product.fromJson(dynamic json) => _$ProductFromJson(json);
}

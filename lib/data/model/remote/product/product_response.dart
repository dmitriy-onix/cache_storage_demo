import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductResponse {
  final String id;
  final String name;
  final double price;

  ProductResponse({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
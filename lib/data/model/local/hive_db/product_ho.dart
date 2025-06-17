import 'package:hive_ce_flutter/hive_flutter.dart';

class ProductHO extends HiveObject {
  final String id;
  final String name;
  final double price;

  ProductHO({required this.id, required this.name, required this.price});

  @override
  String toString() {
    return 'ProductDB(id: $id, name: $name, price: $price)';
  }
}

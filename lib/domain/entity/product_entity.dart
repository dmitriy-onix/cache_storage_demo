class ProductEntity {
  final String id;
  final String name;
  final double price;

  ProductEntity({required this.id, required this.name, required this.price});

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, price: $price)';
  }
}

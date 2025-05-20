class SembastCacheData {
  final String value;
  final int createdAtMillis;

  SembastCacheData({
    required this.value,
    required this.createdAtMillis,
  });

  Map<String, dynamic> toJson() => {
        'value': value,
        'createdAtMillis': createdAtMillis,
      };

  factory SembastCacheData.fromJson(Map<String, dynamic> json) {
    return SembastCacheData(
      value: json['value'] as String,
      createdAtMillis: json['createdAtMillis'] as int,
    );
  }

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(createdAtMillis);
}

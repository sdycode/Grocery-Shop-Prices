// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:groceryshopprices/lib.dart';

class PriceModel {
  MeasureType measureType;
  int price;
  int qty;
  PriceModel({
    required this.measureType,
    required this.price,
    required this.qty,
  });

  PriceModel copyWith({
    MeasureType? measureType,
    int? price,
    int? qty,
  }) {
    return PriceModel(
      measureType: measureType ?? this.measureType,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'measureType': measureType.name,
      'price': price,
      'qty': qty,
    };
  }

  factory PriceModel.fromMap(Map map) {
    return PriceModel(
      measureType: ((map['measureType'] ?? "") as String).getMeasureType(),
      price: map['price'] as int,
      qty: map['qty'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceModel.fromJson(String source) =>
      PriceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PriceModel(measureType: $measureType, price: $price, qty: $qty)';

  @override
  bool operator ==(covariant PriceModel other) {
    if (identical(this, other)) return true;

    return other.measureType == measureType &&
        other.price == price &&
        other.qty == qty;
  }

  @override
  int get hashCode => measureType.hashCode ^ price.hashCode ^ qty.hashCode;
}

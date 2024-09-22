// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:groceryshopprices/lib.dart';

class ItemDynamic {
  String id;
  DateTime date;
  List<PriceModel> costPrices;
  List<PriceModel> sellingPrices;
  ItemDynamic({
    required this.id,
    required this.date,
    required this.costPrices,
    required this.sellingPrices,
  });

  ItemDynamic copyWith({
    String? id,
    DateTime? date,
    List<PriceModel>? costPrices,
    List<PriceModel>? sellingPrices,
  }) {
    return ItemDynamic(
      id: id ?? this.id,
      date: date ?? this.date,
      costPrices: costPrices ?? this.costPrices,
      sellingPrices: sellingPrices ?? this.sellingPrices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'costPrices': costPrices.map((x) => x.toMap()).toList(),
      'sellingPrices': sellingPrices.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemDynamic.fromMap(Map map) {
    return ItemDynamic(
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      costPrices: List<PriceModel>.from(
        ((map['costPrices'] ?? []) as List).map<PriceModel>(
          (x) => PriceModel.fromMap(x as Map),
        ),
      ),
      sellingPrices: List<PriceModel>.from(
        ((map['sellingPrices'] ?? []) as List).map<PriceModel>(
          (x) => PriceModel.fromMap(x as Map),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDynamic.fromJson(String source) =>
      ItemDynamic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemDynamic(id: $id, date: $date, costPrices: $costPrices, sellingPrices: $sellingPrices)';
  }

  @override
  bool operator ==(covariant ItemDynamic other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        listEquals(other.costPrices, costPrices) &&
        listEquals(other.sellingPrices, sellingPrices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        costPrices.hashCode ^
        sellingPrices.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:groceryshopprices/lib.dart';

class Item {
  String id;
  String name;
  String description;
  List<String> imageLinks;
  List<String> altenateNames;
  List<MeasureType> measureTypes;
  String shopId;
  Item({
    required this.id,
    required this.name,
    this.description = "",
    required this.imageLinks,
    required this.altenateNames,
    required this.measureTypes,
    required this.shopId,
  });

  Item copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? imageLinks,
    List<String>? altenateNames,
    List<MeasureType>? measureTypes,
    String? shopId,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageLinks: imageLinks ?? this.imageLinks,
      altenateNames: altenateNames ?? this.altenateNames,
      measureTypes: measureTypes ?? this.measureTypes,
      shopId: shopId ?? this.shopId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageLinks': imageLinks,
      'altenateNames': altenateNames,
      'measureTypes': measureTypes.map((x) => x.name).toList(),
      'shopId': shopId,
    };
  }

  factory Item.fromMap(Map  map) {
    return Item(
       id: map['id'] as String,
      name: map['name'] as String,
      imageLinks: List<String>.from(((map['imageLinks'] ?? []) as List)),
      altenateNames: List<String>.from(((map['altenateNames'] ?? []) as List)),
      measureTypes: List<MeasureType>.from(
        ((map['measureTypes'] ?? []) as List).map<MeasureType>(
          (x) => (x as String).getMeasureType(),
        ),
      ),
      shopId: map['shopId'] as String,
    );
  }
/*

  id: map['id'] as String,
      name: map['name'] as String,
      imageLinks: List<String>.from(((map['imageLinks'] ?? []) as List)),
      altenateNames: List<String>.from(((map['altenateNames'] ?? []) as List)),
      measureTypes: List<MeasureType>.from(
        ((map['measureTypes'] ?? []) as List).map<MeasureType>(
          (x) => (x as String).getMeasureType(),
        ),
      ),
*/
  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, description: $description, imageLinks: $imageLinks, altenateNames: $altenateNames, measureTypes: $measureTypes, shopId: $shopId)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      listEquals(other.imageLinks, imageLinks) &&
      listEquals(other.altenateNames, altenateNames) &&
      listEquals(other.measureTypes, measureTypes) &&
      other.shopId == shopId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      imageLinks.hashCode ^
      altenateNames.hashCode ^
      measureTypes.hashCode ^
      shopId.hashCode;
  }
}

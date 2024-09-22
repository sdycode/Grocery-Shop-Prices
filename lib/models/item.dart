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
  Item({
    required this.id,
    required this.name,
    this.description = "",
    required this.imageLinks,
    required this.altenateNames,
    required this.measureTypes,
  });

  Item copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? imageLinks,
    List<String>? altenateNames,
    List<MeasureType>? measureTypes,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageLinks: imageLinks ?? this.imageLinks,
      altenateNames: altenateNames ?? this.altenateNames,
      measureTypes: measureTypes ?? this.measureTypes,
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
    };
  }

  factory Item.fromMap(Map map) {
    return Item(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageLinks: List<String>.from(((map['imageLinks'] ?? []) as List)),
      altenateNames: List<String>.from(((map['altenateNames'] ?? []) as List)),
      measureTypes: List<MeasureType>.from(
        ((map['measureTypes'] ?? []) as List).map<MeasureType>(
          (x) => (x as String).getMeasureType(),
        ),
      ),
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
    return 'Item(id: $id, name: $name, description: $description, imageLinks: $imageLinks, altenateNames: $altenateNames, measureTypes: $measureTypes)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.imageLinks, imageLinks) &&
        listEquals(other.altenateNames, altenateNames) &&
        listEquals(other.measureTypes, measureTypes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageLinks.hashCode ^
        altenateNames.hashCode ^
        measureTypes.hashCode;
  }
}

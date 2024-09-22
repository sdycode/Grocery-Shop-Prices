// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShopModel {
  String id;
  String ownerUid;
  String name;
  String description;
  List<String> images;
  String primaryGmail;
  List<String> gmailIds;
  String city;
  List<String> requestedCameIds;
  ShopModel({
    required this.id,
    required this.ownerUid,
    required this.name,
    this.description = "",
    required this.images,
    required this.primaryGmail,
    required this.gmailIds,
    this.city = "",
    required this.requestedCameIds,
  });

  ShopModel copyWith({
    String? id,
    String? ownerUid,
    String? name,
    String? description,
    List<String>? images,
    String? primaryGmail,
    List<String>? gmailIds,
    String? city,
    List<String>? requestedCameIds,
  }) {
    return ShopModel(
      id: id ?? this.id,
      ownerUid: ownerUid ?? this.ownerUid,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      primaryGmail: primaryGmail ?? this.primaryGmail,
      gmailIds: gmailIds ?? this.gmailIds,
      city: city ?? this.city,
      requestedCameIds: requestedCameIds ?? this.requestedCameIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerUid': ownerUid,
      'name': name,
      'description': description,
      'images': images,
      'primaryGmail': primaryGmail,
      'gmailIds': gmailIds,
      'city': city,
      'requestedCameIds': requestedCameIds,
    };
  }

  factory ShopModel.fromMap(Map map) {
    return ShopModel(
      id: map['id'] as String,
      ownerUid: map['ownerUid'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      images: List<String>.from(((map['images'] ?? []) as List)),
      primaryGmail: map['primaryGmail'] as String,
      gmailIds: List<String>.from(((map['gmailIds'] ?? []) as List)),
      city: map['city'] as String,
      requestedCameIds:
          List<String>.from(((map['requestedCameIds'] ?? []) as List)),
    );
  }
  /*
          id: map['id'] as String,
      ownerUid: map['ownerUid'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      images: List<String>.from(((map['images'] ?? []) as List)),
      primaryGmail: map['primaryGmail'] as String,
      gmailIds: List<String>.from(((map['gmailIds'] ?? []) as List)),
      city: map['city'] as String,
  */

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopModel(id: $id, ownerUid: $ownerUid, name: $name, description: $description, images: $images, primaryGmail: $primaryGmail, gmailIds: $gmailIds, city: $city, requestedCameIds: $requestedCameIds)';
  }

  @override
  bool operator ==(covariant ShopModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ownerUid == ownerUid &&
        other.name == name &&
        other.description == description &&
        listEquals(other.images, images) &&
        other.primaryGmail == primaryGmail &&
        listEquals(other.gmailIds, gmailIds) &&
        other.city == city &&
        listEquals(other.requestedCameIds, requestedCameIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ownerUid.hashCode ^
        name.hashCode ^
        description.hashCode ^
        images.hashCode ^
        primaryGmail.hashCode ^
        gmailIds.hashCode ^
        city.hashCode ^
        requestedCameIds.hashCode;
  }
}

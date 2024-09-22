// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CustomUser {
  String uid;
  String emailId;
  String name;
  String photoUrl;
  List<String> joinedShopIds;
  String? currentShopId;
  CustomUser({
    required this.uid,
    required this.emailId,
    required this.name,
    required this.photoUrl,
    required this.joinedShopIds,
    this.currentShopId,
  });

  CustomUser copyWith({
    String? uid,
    String? emailId,
    String? name,
    String? photoUrl,
    List<String>? joinedShopIds,
    String? currentShopId,
  }) {
    return CustomUser(
      uid: uid ?? this.uid,
      emailId: emailId ?? this.emailId,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      joinedShopIds: joinedShopIds ?? this.joinedShopIds,
      currentShopId: currentShopId ?? this.currentShopId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'emailId': emailId,
      'name': name,
      'photoUrl': photoUrl,
      'joinedShopIds': joinedShopIds,
      'currentShopId': currentShopId,
    };
  }

  factory CustomUser.fromMap(Map map) {
    return CustomUser(
      uid: map['uid'] as String,
      emailId: map['emailId'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
      joinedShopIds: List<String>.from(((map['joinedShopIds'] ?? []) as List)),
      currentShopId:
          map['currentShopId'] != null ? map['currentShopId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomUser.fromJson(String source) =>
      CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomUser(uid: $uid, emailId: $emailId, name: $name, photoUrl: $photoUrl, joinedShopIds: $joinedShopIds, currentShopId: $currentShopId)';
  }

  @override
  bool operator ==(covariant CustomUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.emailId == emailId &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        listEquals(other.joinedShopIds, joinedShopIds) &&
        other.currentShopId == currentShopId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        emailId.hashCode ^
        name.hashCode ^
        photoUrl.hashCode ^
        joinedShopIds.hashCode ^
        currentShopId.hashCode;
  }
}

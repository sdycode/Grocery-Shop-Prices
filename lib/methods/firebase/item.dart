import 'dart:async';

import 'package:groceryshopprices/lib.dart';
Future
removeItem(String itemId, String shopId) async {
  await FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shop_itemids")
      .child(shopId)
      .child(itemId)
      .remove();
  await FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("items")
      .child(itemId)
      .remove();
}

Stream<List<String>> getItemIdsListStream(String shopId) {
  return FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shop_itemids")
      .child(shopId)
      .onValue
      .map((ev) {
    List<String> itemIds = [];

    ev.snapshot.children.forEach((e) {
      try {
        String? key = e.key;
        if (key != null) {
          itemIds.add(key);
        }
      } catch (e) {}
    });
    return itemIds;
  });
}

addItemIdToShop(String shopId, String itemId) async {
  await FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shop_itemids")
      .child(shopId)
      .child(itemId)
      .set(itemId);
}

addNewItem(String shopId, Item item, ItemDynamic itemDynamic) async {
  await addItemIdToShop(shopId, item.id);
  await updateStaticItem(item);
  await updateDynamicItem(itemDynamic);
}

updateStaticItem(Item item) async {
  final ref = FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("items")
      .child(item.id);
  await ref.update(item.toMap());
}

updateDynamicItem(ItemDynamic itemDynamic, {DateTime? date}) async {
  String dateString = (itemDynamic.date).dateToUnder_Score_String();
printLog("prices ${itemDynamic.sellingPrices.toString()}");
  final ref = FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("items_dynamic")
      .child(itemDynamic.id)
      .child(dateString);
  await ref.update(itemDynamic.toMap());
}

Stream<Item?> getStaticItem(String id) {
  return FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("items")
      .child(id)
      .onValue
      .map((data) {
    Item? item;
    try {
      Map? map = data.snapshot.value as Map?;
      if (map != null) {
        item = Item.fromMap(map);
      }
    } catch (e) {
      printLog("err 76 $e");
    }
    return item;
  });
}

Stream<Map<String, ItemDynamic>> loadItemDynamicMapStream(String itemId) {
  return FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("items_dynamic")
      .child(itemId)
      .onValue
      .map((ev) {
    Map<String, ItemDynamic> itemDynamicMap = {};

    ev.snapshot.children.forEach((dd) {
      String? key = dd.key;
      if (key != null) {
        try {
          Map? map = dd.value as Map?;
          if (map != null) {
            ItemDynamic itemDynamic = ItemDynamic.fromMap(map);
            itemDynamicMap[key] = itemDynamic;
          }
        } catch (e) {
          printLog("err 102 $e");
        }
      }
    });
    return itemDynamicMap;
  });
}
